USE [RheemUsers]
GO
/****** Object:  StoredProcedure [dbo].[BuildDSMReport]    Script Date: 06/05/2012 09:31:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[BuildDSMReport] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier
AS
BEGIN
select distinct o.OrganizationID as szID, o.OrganizationName as szName from Organization o3
  INNER JOIN MyOrganizations mo on mo.OrganizationID = o3.OrganizationID and
        mo.PersonID=@PersonID
  Inner JOIN OrganizationParent OP on o3.OrganizationID=OP.OrganizationID
  INNER JOIN Organization o2   on OP.ParentOrganizationID=o2.OrganizationID  AND
        o2.OrganizationType LIKE 'Sales Region%'
  Inner JOIN OrganizationParent OP2 on o2.OrganizationID=OP2.OrganizationID
  INNER JOIN Organization o   on OP2.ParentOrganizationID=o.OrganizationID  AND
        o.OrganizationType LIKE 'Sales Zone%'
where
 o3.OrganizationType LIKE 'Sales Territory%'
	ORDER BY o.OrganizationName


select distinct o.OrganizationID as srID, o.OrganizationName as srName, 
    o3.OrganizationID as szID, o3.OrganizationName as szName FROM 
   Organization o2
  INNER JOIN MyOrganizations mo on mo.OrganizationID = o2.OrganizationID and
        mo.PersonID=@PersonID
  Inner JOIN OrganizationParent OP on o2.OrganizationID=OP.OrganizationID
  INNER JOIN Organization o   on OP.ParentOrganizationID=o.OrganizationID  AND
        o.OrganizationType LIKE 'Sales Region%'
  INNER JOIN OrganizationParent OP2 on o.OrganizationID=OP2.OrganizationID
  INNER JOIN Organization o3 on OP2.ParentOrganizationID=o3.OrganizationID
  where
   o2.OrganizationType LIKE 'Sales Territory%'
    ORDER BY o3.OrganizationName, o.OrganizationName


SELECT o.OrganizationName as srName, o.OrganizationID as srID,
        p.FirstName + ' ' +  p.LastName Fullname,
        isnull(Disabled, 0) as IsDisabled
	FROM PersonOrganization po
	INNER JOIN Organization o ON po.OrganizationID = o.OrganizationID  
	INNER JOIN MyOrganizations mo ON 
			   o.OrganizationID=mo.OrganizationID AND 
			   mo.PersonID=@PersonID
	INNER JOIN rheemusers..Person p ON po.PersonID = p.PersonID 
	WHERE o.OrganizationType like 'Sales Region%' 
	ORDER BY o.OrganizationName

select o.OrganizationID as srID, o.OrganizationName as srName, 
   o2.OrganizationID stID, o2.OrganizationName stName FROM 
   Organization o2
  INNER JOIN MyOrganizations mo on mo.OrganizationID = o2.OrganizationID and
        mo.PersonID=@PersonID
  Inner JOIN OrganizationParent OP on o2.OrganizationID=OP.OrganizationID
  INNER JOIN Organization o   on OP.ParentOrganizationID=o.OrganizationID
where
 o2.OrganizationType LIKE 'Sales Territory%'  AND
 o.OrganizationType LIKE 'Sales Region%'
 ORDER BY o.OrganizationName, o2.OrganizationName

SELECT o.OrganizationName as stName, o.OrganizationID as stID,
        p.FirstName + ' ' +  p.LastName Fullname,
        isnull(Disabled, 0) as IsDisabled
	FROM PersonOrganization po
	INNER JOIN Organization o ON po.OrganizationID = o.OrganizationID  
	INNER JOIN MyOrganizations mo ON 
			   o.OrganizationID=mo.OrganizationID AND 
			   mo.PersonID=@PersonID
	INNER JOIN rheemusers..Person p ON po.PersonID = p.PersonID 
	WHERE o.OrganizationType like 'Sales Territory%' 
	ORDER BY o.OrganizationName

SELECT o.OrganizationID as distID, o.OrganizationName as distName, o.OrganizationType as distType, 
	   o2.organizationID as stID, o2.OrganizationName as stName, 
	   ISNULL(p.FirstName, 'NO') + ' ' + ISNULL(p.LastName, 'DSM SELECTED') as DSMName, 
	   a.AddressLine1 + ' ' + a.AddressLine2 + ' ' + a.City + ', ' + a.State + ' ' + a.PostalCode + ' ' + a.Country as Address
	FROM Organization o
	INNER JOIN DistributorOrganization do ON o.OrganizationID=do.OrganizationID AND
				(do.Disabled IS NULL OR do.Disabled = '0')
	INNER JOIN OrganizationParent op ON o.OrganizationID=op.OrganizationID
	INNER JOIN Organization o2 ON op.ParentOrganizationID=o2.OrganizationID AND
		   o2.OrganizationType LIKE 'Sales Territory%'
	INNER JOIN MyOrganizations mo ON o2.OrganizationID=mo.OrganizationID AND 
			   mo.PersonID=@PersonID
	LEFT OUTER JOIN Person p ON do.DSMPersonID=p.PersonID
	LEFT OUTER JOIN Address a ON o.PrimaryAddressID=a.AddressID
	ORDER BY o2.OrganizationName, o.OrganizationName
  

SELECT o.OrganizationID, o.OrganizationName, o.OrganizationType, 
	   o2.organizationID as distID, o2.OrganizationName as distName,
	   o3.organizationID as stID, o3.OrganizationName as stName, 
	   ISNULL(p.FirstName, 'NO') + ' ' + ISNULL(p.LastName, 'DSM SELECTED') as DSMName, 
   	   a.AddressLine1 + ' ' + a.AddressLine2 + ' ' + a.City + ', ' + a.State + ' ' + a.PostalCode + ' ' + a.Country as Address
	FROM Organization o
	INNER JOIN DistributorOrganization do ON o.OrganizationID=do.OrganizationID AND
				(do.Disabled IS NULL OR do.Disabled = '0')
	INNER JOIN OrganizationParent op ON o.OrganizationID=op.OrganizationID
	INNER JOIN Organization o2 ON op.ParentOrganizationID=o2.OrganizationID AND
		   o2.OrganizationType like 'Distributor%'
	INNER JOIN OrganizationParent op2 ON o2.OrganizationID=op2.OrganizationID
	INNER JOIN Organization o3 ON op2.ParentOrganizationID=o3.OrganizationID AND
		   o3.OrganizationType LIKE 'Sales Territory%'
	INNER JOIN MyOrganizations mo ON o3.OrganizationID=mo.OrganizationID AND 
			   mo.PersonID=@PersonID
	LEFT OUTER JOIN Person p ON do.DSMPersonID=p.PersonID
	LEFT OUTER JOIN Address a ON o.PrimaryAddressID=a.AddressID
	ORDER BY o3.OrganizationName, o2.OrganizationName, o.OrganizationName

END
