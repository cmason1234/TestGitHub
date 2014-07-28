USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMiscClaimsReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetMiscClaimsReport]
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
CREATE PROCEDURE [dbo].[GetMiscClaimsReport] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
    SELECT do.OrganizationName DistributorName, co.OrganizationName ContractorName,  convert(varchar,mc.ClaimDate,101) cd, mc.* 
	FROM rheemdb..EC_MiscClaims mc, rheemusers..Organization do, rheemusers..Organization co  
	WHERE mc.OrganizationId = do.OrganizationID and 
          mc.AllocatedToOrganizationId = co.OrganizationID and 
          mc.ClaimYear = 2010   
    ORDER BY  DistributorName, ContractorName, mc.claimDate 

END
GO
