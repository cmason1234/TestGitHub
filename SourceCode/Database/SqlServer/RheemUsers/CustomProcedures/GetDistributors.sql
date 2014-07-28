USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributors]
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
CREATE PROCEDURE [dbo].[GetDistributors] 
	-- Add the parameters for the stored procedure here
	@StartsWith varchar(128)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT a.State,a.City,do.*,o.* FROM DistributorOrganization do
	    INNER JOIN Organization o ON do.OrganizationID=o.OrganizationID AND 
		    (do.disabled <> '1' OR do.Disabled IS NULL) and do.AC = 1
	    LEFT OUTER JOIN rheemusers..Address a ON a.AddressID = o.PrimaryAddressID
		WHERE o.OrganizationName LIKE @StartsWith
		order by o.OrganizationName

END
GO
