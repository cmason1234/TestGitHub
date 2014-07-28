USE [WaterHeaterDB]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uspCustomersGet]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[uspCustomersGet]
GO



/****** Object:  StoredProcedure [dbo].[uspCustomersGet]    Script Date: 02/14/2013 08:14:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE  PROCEDURE [dbo].[uspCustomersGet] (@PersonID varchar(128), @SearchType varchar(30), @SearchValue varchar(30))

AS
DECLARE @OrganizationType char(32),
	@OrganizationName varchar(100),
	@RegionID varchar(5),
	@SalesID varchar(20)

/* Temp Code */
/*
DECLARE @UserName varchar(100)
set @username = 'jeffreimer'
SET @personID = (select personID from rheemusers..Person where username=@username )
*/

SELECT @OrganizationType = o.OrganizationType,
	@OrganizationName = o.OrganizationName
FROM rheemusers..Person p, 
     rheemusers..Organization o
WHERE p.PersonID=@PersonID
  AND p.PrimaryOrganizationId = o.OrganizationID

IF @OrganizationType = 'Water Heater Region'
  BEGIN
    SELECT @OrganizationName = UPPER(@OrganizationName)

    SELECT @RegionID = 
      CASE @OrganizationName 
        WHEN 'REGION C (SOUTHWEST)' THEN 'C'
        WHEN 'REGION E (MIDWEST/CENTRAL)' THEN 'E'
        WHEN 'REGION G (SOUTHEAST)' THEN 'G'
        WHEN 'REGION A (WEST)' THEN 'A'
        WHEN 'REGION J (NORTHEAST)' THEN 'J'
       END

    SELECT 
      CustDesc = dbo.udfGetCustomerDesc(ac.CustName,ac.Addr_City,ac.Addr_Line2, 
	  '(' + cast(ac.Parent as varchar(50)) + '/' + cast(ac.CustNumber as varchar(50) ) + ')' 
	  ),
      ac.CustNumber, 
      ac.CustName, 
      ac.Addr_Line1, 
      coalesce(ac.Addr_Line2,'') Addr_Line2,
      ac.Addr_City,
      ac.Addr_State,
      ac.Addr_Zip
    FROM AccumCustomer ac
    WHERE ac.RegionID = @RegionID AND ac.CustTierID <> 'SC' 
    ORDER BY ac.CustNumber
  END

IF @OrganizationType = 'WHCustomer' 
  BEGIN
    EXEC rheemusers..LoadMyOrganizations @personID 

    SELECT CustDesc = dbo.udfGetCustomerDesc(o.OrganizationName, a.City, a.AddressLine1, whc.CustomerNumber),
       CustNumber = whc.customerNumber, o.organizationName, a.AddressLine1, a.AddressLine2, a.city, a.STate, a.PostalCode
    FROM rheemusers..WHCustomer whc, 
         rheemusers..myOrganizations mo,
         RheemUsers..Organization o,
         rheemusers..Address a 
    WHERE mo.personid =  @personID
      AND mo.OrganizationID = o.OrganizationID
      AND o.OrganizationID = whc.OrganizationID
      AND whc.PrimaryAddressID = a.AddressID
    ORDER BY whc.CustomerNumber 
  END

IF  @OrganizationType = 'Distributor'
  BEGIN
    EXEC rheemusers..LoadMyOrganizations @personID 

    SELECT CustDesc = dbo.udfGetCustomerDesc(o.OrganizationName, a.City, a.AddressLine1,
	'(' + cast(whc.OracleAccountNumber as varchar(50)) + '/' + cast(whc.OracleCustomerSiteNumberWHD as varchar(50) ) + ')' ),
       CustNumber = whc.OracleCustomerSiteNumberWHD, o.organizationName, a.AddressLine1, a.AddressLine2, a.city, a.STate, a.PostalCode
    FROM rheemusers..DistributorOrganization whc, 
         rheemusers..myOrganizations mo,
         RheemUsers..Organization o,
         rheemusers..Address a 
    WHERE mo.personid =  @personID
      AND mo.OrganizationID = o.OrganizationID
      AND o.OrganizationID = whc.OrganizationID
      AND whc.PrimaryAddressID = a.AddressID
      AND whc.WHTank = '1'
    ORDER BY CustDesc, whc.OracleCustomerSiteNumberWHD 
  END


IF @OrganizationType = 'WHAgent'
  BEGIN
EXEC rheemusers..LoadMyOrganizations @personID 

SELECT CustDesc = dbo.udfGetCustomerDesc(ac.CustName,ac.Addr_City,ac.Addr_Line2, 
'(' + cast(ac.Parent as varchar(50)) + '/' + cast(ac.CustNumber as varchar(50) ) + ')' 
),
      ac.CustNumber, 
      ac.CustName, 
      ac.Addr_Line1, 
      coalesce(ac.Addr_Line2,'') Addr_Line2,
      ac.Addr_City,
      ac.Addr_State,
      ac.Addr_Zip
  FROM AccumCustomer ac
  WHERE 
ac.CustNumber in (
   select  do.OracleCustomerSiteNumberWHD from rheemusers..MyOrganizations mo, rheemusers..DistributorOrganization do 
      where
   mo.PersonID=@PersonID and 
   mo.OrganizationID = do.OrganizationID and 
   (WHTankDisabled = '0' or WHTankDisabled is null)
   ) or 
ac.CustNumber in (
   select  whc.CustomerNumber from rheemusers..MyOrganizations mo, rheemusers..WHCustomer whc 
      where
   mo.PersonID=@PersonID and 
   mo.OrganizationID = whc.OrganizationID
)  
order by CustDesc, CustNumber


  END

IF @OrganizationType = 'Division'
  BEGIN
    IF UPPER(@SearchType) = 'CUSTOMERNUMBER'
      BEGIN
        SELECT CustDesc = dbo.udfGetCustomerDesc(ac.CustName,ac.Addr_City,ac.Addr_Line2, 
		'(' + cast(ac.Parent as varchar(50)) + '/' + cast(ac.CustNumber as varchar(50) ) + ')' 
		
		),
               ac.CustNumber, 
               ac.CustName, 
               ac.Addr_Line1, 
               coalesce(ac.Addr_Line2,'') Addr_Line2,
               ac.Addr_City,
               ac.Addr_State,
               ac.Addr_Zip
        FROM AccumCustomer ac
        WHERE CustNumber = @SearchValue
		ORDER by CustDesc
      END
    IF UPPER(@SearchType) = 'PARENTCUSTOMERNUMBER'
      BEGIN
        SELECT CustDesc = dbo.udfGetCustomerDesc(ac.CustName,ac.Addr_City,ac.Addr_Line2, 
		'(' + cast(ac.Parent as varchar(50)) + '/' + cast(ac.CustNumber as varchar(50) ) + ')' ),
               ac.CustNumber, 
               ac.CustName, 
               ac.Addr_Line1, 
               coalesce(ac.Addr_Line2,'') Addr_Line2,
               ac.Addr_City,
               ac.Addr_State,
               ac.Addr_Zip
        FROM AccumCustomer ac
        WHERE Parent = @SearchValue
		ORDER by CustDesc
      END
    IF UPPER(@SearchType) = 'PARENTGROUPCODE'
      BEGIN
        SELECT CustDesc = dbo.udfGetCustomerDesc(ac.CustName,ac.Addr_City,ac.Addr_Line2, 
		'(' + cast(ac.Parent as varchar(50)) + '/' + cast(ac.CustNumber as varchar(50) ) + ')'
		),
               ac.CustNumber, 
               ac.CustName, 
               ac.Addr_Line1, 
               coalesce(ac.Addr_Line2,'') Addr_Line2,
               ac.Addr_City,
               ac.Addr_State,
               ac.Addr_Zip
        FROM AccumCustomer ac
        WHERE ParentGroup = @SearchValue
		ORDER by CustDesc
      END
    IF UPPER(@SearchType) = 'AGENCYID'
      BEGIN
        SELECT CustDesc = dbo.udfGetCustomerDesc(ac.CustName,ac.Addr_City,ac.Addr_Line2, 
		'(' + cast(ac.Parent as varchar(50)) + '/' + cast(ac.CustNumber as varchar(50) ) + ')'
		),
               ac.CustNumber, 
               ac.CustName, 
               ac.Addr_Line1, 
               coalesce(ac.Addr_Line2,'') Addr_Line2,
               ac.Addr_City,
               ac.Addr_State,
               ac.Addr_Zip
        FROM AccumCustomer ac
        WHERE SalesID = @SearchValue
		ORDER by CustDesc
      END
  END

IF @OrganizationType <> 'WHAgent' AND @OrganizationType <> 'WHCustomer' AND @OrganizationType <> 'Division'
 AND @OrganizationType <> 'Water Heater Region' and @OrganizationType <> 'Distributor'
  BEGIN
    SELECT CustDesc = NULL, CustNumber = NULL
  END

/*
select distinct CustDesc = dbo.udfGetCustomerDesc(a.CustName,a.Addr_City,a.Addr_Line1, a.CustNumber),
      a.CustNumber, 
       a.CustName, 
			 a.Addr_Line1, 
			 coalesce(a.Addr_Line2,'') Addr_Line2,
			 a.Addr_City,
			 a.Addr_State,
			 a.Addr_Zip
from   accumCustomer a 
where  a.CustNumber IN ('3663271', '7629402','7629407','7629701','7629401' )
*/

GO

