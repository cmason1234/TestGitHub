USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetVendors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetVendors]
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
CREATE PROCEDURE [dbo].[GetVendors] 
	-- Add the parameters for the stored procedure here
	@OrganizationName nvarchar(250),
	@City varchar(50),
	@State varchar(3)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT a.VendorOrganizationID,a.IsTradeShowMgmtOrg,b.OrganizationName,c.City,c.State
	FROM rheemusers..VendorOrganization a, 
		 rheemusers..Organization b,
		 rheemusers..Address c
	WHERE b.OrganizationName like @OrganizationName and
		  c.City like @City and
		  c.State like @State and
		  a.OrganizationID = b.OrganizationID and
		  b.PrimaryAddressID = c.AddressID
	ORDER BY b.OrganizationName

END
GO
