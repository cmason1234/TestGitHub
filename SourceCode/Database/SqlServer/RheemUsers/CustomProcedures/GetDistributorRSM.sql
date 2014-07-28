USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorRSM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorRSM]
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
CREATE PROCEDURE [dbo].[GetDistributorRSM] 
	-- Add the parameters for the stored procedure here
	@OrgID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select p.FirstName + ' ' + p.LastName As RSMFullName, p.PersonId, p.emailAddress  from Person p
   where
PersonID in (
   select poLevel1 .PersonID  from OrganizationParent OPter, organization oReg, PersonOrganization poLevel1
      where
   opter.OrganizationID in (
      select oTerLevel1.organizationid from OrganizationParent opDisLevel1, Organization oTerLevel1
         where
      opDisLevel1.OrganizationID =@OrgID and 
      opDisLevel1.ParentOrganizationID = oTerLevel1.OrganizationID and 
      oTerLevel1.OrganizationType ='Sales Territory') and 
   OPter .ParentOrganizationID = oreg.OrganizationID and 
   oreg.OrganizationID = poLevel1.OrganizationID ) or 
  
PersonID in (
   select poLevel1 .PersonID  from OrganizationParent OPter, organization oReg, PersonOrganization poLevel1
      where
   opter.OrganizationID in (
      select oTerLevel1.organizationid from OrganizationParent opDisLevel1, Organization oTerLevel1
         where
      opDisLevel1.OrganizationID in (      
         select oCorpL2.OrganizationID  from OrganizationParent opL2 , rheemusers..Organization oCorpL2
            where
         opl2.OrganizationID = @OrgID and 
         opL2 .ParentOrganizationID = oCorpL2 .OrganizationID and 
         oCorpL2 .OrganizationType ='Distributor'
      )  and 
      opDisLevel1.ParentOrganizationID = oTerLevel1.OrganizationID and 
      oTerLevel1.OrganizationType ='Sales Territory') and 
   OPter .ParentOrganizationID = oreg.OrganizationID and 
   oreg.OrganizationID = poLevel1.OrganizationID ) 
   
    

	
END
GO
