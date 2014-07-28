USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorLocatorSummaryByPerson]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorLocatorSummaryByPerson]
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
CREATE PROCEDURE [dbo].[GetDistributorLocatorSummaryByPerson] 
	-- Add the parameters for the stored procedure here
	@POCPersonID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select o.OrganizationID, o.OrganizationName,p.EmailAddress dsmEmailAddress, 
p.FirstName + ' ' + p.lastname DSMFullName,
a.AddressLine1 , a.City + ' ' +  a.State  + a.PostalCode csz
 from rheemusers ..DistributorLocatorProcessCoordinator dlpc 
   left outer join rheemusers ..DistributorLocatorProcess dlp on 
      dlpc.DistributorLocatorProcessID = dlp.DistributorLocatorProcessID 
   left outer join rheemusers..Organization o on 
      dlp.OrganizationID = o.OrganizationID   
   left outer join rheemusers..Person p on 
      dlp.DSMPersonID = p.PersonID 
   left outer join rheemusers..DistributorOrganization do on 
      dlp.OrganizationID = do.OrganizationID 
   left outer join rheemusers..Address a on 
      do.PrimaryAddressID = a.AddressID 
where
   dlpc.POCPersonID = @POCPersonID

END
GO
