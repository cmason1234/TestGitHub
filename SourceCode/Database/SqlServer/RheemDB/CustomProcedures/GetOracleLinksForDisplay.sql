USE [rheemdb]
GO
SET ANSI_NULLS ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOracleLinksForDisplay]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetOracleLinksForDisplay]
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOracleLinksForDisplay] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT dbo.OracleLink.OracleLinkID, dbo.OracleLink.OracleModuleID, dbo.OracleLink.URL, 
	dbo.OracleLink.URLText, dbo.OracleLink.AltText, dbo.OracleLink.Active, 
	dbo.OracleLink.AlertText, dbo.OracleLink.LinkOrder, dbo.OracleModule.ModuleName
	FROM dbo.OracleLink INNER JOIN
	dbo.OracleModule ON dbo.OracleLink.OracleModuleID = dbo.OracleModule.OracleModuleID
	ORDER BY dbo.OracleModule.ModuleOrder, dbo.OracleLink.LinkOrder
	
END
