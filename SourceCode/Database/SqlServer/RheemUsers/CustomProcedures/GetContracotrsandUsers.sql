USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContractorAndUsers]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContractorAndUsers]
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetContractorAndUsers] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueIdentifier
	,@DistributorID uniqueIdentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
select o.OrganizationID, o.OrganizationName, Phone, ContractorOrganizationID, 
       DesignStar, DesignStarActive, DesignStarGizmo, ProtectionPlus, KwikComfort, 
       AddressLine1, AddressLine2, City, State, PostalCode, ACContractor, PoolAndSpaContractor,
       GeneratorContractor, Installer, DealerNumber, radius
 from rheemusers..MyOrganizations mo
   inner join rheemusers..organization o on mo.OrganizationID   = o.OrganizationId and 
      (o.OrganizationType  = 'Dealer' or o.OrganizationType  = 'Contractor' )
   inner join rheemusers..ContractorOrganization co on mo.OrganizationID   = co.OrganizationId and 
     co.ACContractor = 1 and (co.Disabled is null or co.Disabled ='0')
   inner join rheemusers..Address a on co.PrimaryAddressID = a.AddressID
   inner join rheemusers..ContractorAC cac on mo.OrganizationID = cac.organizationid and
          cac.distributorOrganizationid= @DistributorID 
  where 
     mo.personID = @PersonID
  order by o.OrganizationName

  SELECT o.OrganizationID, o.OrganizationName, p.PersonID, p.FirstName + ' ' +  p.LastName Fullname 
        FROM rheemusers..PersonOrganization po 
        LEFT JOIN rheemusers..Organization o ON po.OrganizationID = o.OrganizationID  
        LEFT JOIN rheemusers..Person p ON po.PersonID = p.PersonID 
        WHERE o.OrganizationID in
          (select o.OrganizationID from rheemusers..MyOrganizations mo
   inner join rheemusers..organization o on mo.OrganizationID   = o.OrganizationId and 
      (o.OrganizationType  = 'Dealer' or o.OrganizationType  = 'Contractor' )
   inner join rheemusers..ContractorOrganization co on mo.OrganizationID   = co.OrganizationId and 
     co.ACContractor = 1
   inner join rheemusers..ContractorAC cac on mo.OrganizationID = cac.organizationid and
          cac.distributorOrganizationid= @DistributorID 
  where 
     mo.personID         = @PersonID)
         and 
              ISNULL(p.Disabled, 0) = 0 
        ORDER BY o.OrganizationName, p.LastName 

select pr.PersonID as childPersonID, ApplicationName, RoleName, p.FirstName + ' ' +  p.LastName Fullname 
  from personrole pr
  inner join ApplicationRole apr on pr.ApplicationRoleID = apr.ApplicationRoleID
  inner join Application app on apr.ApplicationID = app.ApplicationID
  inner join Role r on apr.RoleID = r.RoleID
  inner join Person p on pr.PersonID=p.PersonID
where pr.PersonID IN (
      SELECT  p.PersonID
        FROM rheemusers..PersonOrganization po 
        LEFT JOIN rheemusers..Organization o ON po.OrganizationID = o.OrganizationID  
        LEFT JOIN rheemusers..Person p ON po.PersonID = p.PersonID 
        WHERE o.OrganizationID in
          (select o.OrganizationID from rheemusers..MyOrganizations mo
   inner join rheemusers..organization o on mo.OrganizationID   = o.OrganizationId and 
      (o.OrganizationType  = 'Dealer' or o.OrganizationType  = 'Contractor' )
   inner join rheemusers..ContractorOrganization co on mo.OrganizationID   = co.OrganizationId and 
     co.ACContractor = 1
   inner join rheemusers..ContractorAC cac on mo.OrganizationID = cac.organizationid and
          cac.distributorOrganizationid= @DistributorID  
  where 
     mo.personID         = @PersonID)
         and 
              ISNULL(p.Disabled, 0) = 0 
 ) order by fullname, pr.personid, ApplicationName, RoleName
END
GO
