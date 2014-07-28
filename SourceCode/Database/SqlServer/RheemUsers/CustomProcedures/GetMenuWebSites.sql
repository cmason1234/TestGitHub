USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuWebSites]') AND type in (N'P', N'PC'))
DROP procedure [dbo].[GetMenuWebSites]
GO


/****** Object:  UserDefinedFunction [dbo].[GetMenuWebSites]    Script Date: 05/17/2012 12:59:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE procedure [dbo].[GetMenuWebSites] 
(
	-- Add the parameters for the function here
	@MenuID uniqueidentifier
)

AS
BEGIN
	SELECT rws.WebSiteName FROM MenuWebSite mws
	  INNER JOIN RheemWebSite rws on rws.RheemWebSiteID=mws.RheemWebSiteID
	   WHERE MenuID =@MenuID
END


GO


