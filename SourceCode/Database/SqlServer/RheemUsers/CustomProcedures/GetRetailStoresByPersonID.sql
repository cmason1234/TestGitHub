USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRetailStoresByPersonID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRetailStoresByPersonID]
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
CREATE PROCEDURE [dbo].[GetRetailStoresByPersonID]
    -- Add the parameters for the stored procedure here
    @PersonID uniqueidentifier,
    @StoreName varchar(128)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT *, 
           disO.OrganizationName DistributorName, 
           disO.OrganizationID disOrganizationID 
    FROM rheemusers..MyOrganizations mo, 
         rheemusers..organization o, 
         rheemusers..RetailOrganization ro, 
         rheemusers..Address a, 
         rheemusers..DistributorOrganization do, 
         rheemusers..Organization disO 
    WHERE mo.personID = @PersonID and
          mo.OrganizationID = o.OrganizationId and 
          o.OrganizationType = 'Retail' and 
          o.OrganizationID = ro.OrganizationId and 
          ro.PrimaryAddressID = a.AddressID and 
          ro.ACDistributorOrganizationID = disO.OrganizationID and 
          disO.OrganizationID = do.OrganizationID and 
          o.OrganizationName like '%' + @StoreName + '%'
    ORDER BY o.OrganizationName

END
GO
