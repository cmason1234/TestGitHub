USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetHomeDepotStoresByPersonID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetHomeDepotStoresByPersonID]
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
CREATE PROCEDURE [dbo].[GetHomeDepotStoresByPersonID] 
    -- Add the parameters for the stored procedure here
    @PersonID uniqueidentifier,
	@HomeDepotStoreCheck integer
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT DISTINCT TOP 200 ro.HomeDepotStoreNumber,
                ro.HomeDepotStoreName,
                a.AddressLine1+a.AddressLine2 AS Address,
                a.City,
                a.State,
                a.PostalCode
    FROM  rheemusers ..OrganizationParent op
    JOIN rheemusers..RetailOrganization ro ON op.ParentOrganizationID = ro.OrganizationID
    JOIN rheemusers ..MyOrganizations mo ON mo.OrganizationID=op.OrganizationID and mo.PersonID = @PersonID
    JOIN rheemusers..ContractorOrganization co ON mo.OrganizationID = co.OrganizationID
    LEFT OUTER JOIN rheemusers..Address a ON a.AddressID=ro.PrimaryAddressID
    WHERE ro.HomeDepotStoreNumber != 26 and ro.HomeDepotStoreNumber != 0 AND
	(@HomeDepotStoreCheck is Null or ro.HomeDepotStoreNumber = @HomeDepotStoreCheck)
    ORDER BY ro.HomeDepotStoreName 

END
GO
