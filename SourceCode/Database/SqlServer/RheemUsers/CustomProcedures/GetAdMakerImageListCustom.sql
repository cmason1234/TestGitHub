USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetAdMakerImageListCustom]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetAdMakerImageListCustom]
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
CREATE PROCEDURE [dbo].[GetAdMakerImageListCustom] 
    -- Add the parameters for the stored procedure here
    @Name varchar(50),
    @ImageType varchar(50),
    @BrandName varchar(50),
    @PageSize varchar(50),
    @AssetCategory varchar(50),
    @BlackWhite bit,
    @Disabled bit

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

SELECT a.AdMakerImageID, a.Name, a.ImageType, a.ImageUrl, a.PageSize, a.AssetCategory, a.BlackWhite, a.Disabled, a.BrandID, b.BrandName
FROM rheemusers..AdMakerImage a
    LEFT OUTER JOIN RheemDB..Brand b ON a.BrandID=b.BrandID
WHERE 	(LEN(@Name) = 0 OR a.Name like '%' + @Name + '%') and
		(LEN(@ImageType) = 0 OR a.ImageType like '%' + @ImageType + '%') and
		(LEN(@BrandName) = 0 OR b.BrandName like '%' + @BrandName + '%') and
		(LEN(@PageSize) = 0 OR a.PageSize like '%' + @PageSize + '%') and
		(LEN(@AssetCategory) = 0 OR a.AssetCategory like '%' + @AssetCategory + '%') and
		(@BlackWhite = 1 OR a.BlackWhite=0) and
		(@Disabled = 1 OR a.Disabled=0)
Order by a.Name

END
GO
