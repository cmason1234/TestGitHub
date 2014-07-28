USE [rheemusers]

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMenuBrandIDs]') AND type in (N'P', N'PC'))
DROP procedure [dbo].[GetMenuBrandIDs]
GO


/****** Object:  UserDefinedFunction [dbo].[GetMenuBrandIDs]    Script Date: 05/17/2012 12:59:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE procedure [dbo].[GetMenuBrandIDs] 
(
	-- Add the parameters for the function here
	@MenuID uniqueidentifier
)

AS
BEGIN
	SELECT mb.BrandID, b.BrandName FROM MenuBrand mb
	  INNER JOIN RheemDB..Brand b on mb.BrandID = b.BrandID
	   WHERE MenuID =@MenuID
END


GO


