USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCatalogAddendumListCustom]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetCatalogAddendumListCustom]
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
CREATE PROCEDURE [dbo].[GetCatalogAddendumListCustom] 
    -- Add the parameters for the stored procedure here
    @Name varchar(50),
    @BrandName varchar(50),
    @Disabled bit

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

SELECT a.CatalogAddendumID,a.Name, a.FileUrl, a.Disabled, a.BrandID, b.BrandName
FROM rheemusers..CatalogAddendum a
    LEFT OUTER JOIN RheemDB..Brand b ON a.BrandID=b.BrandID
WHERE 	(LEN(@Name) = 0 OR a.Name like '%' + @Name + '%') and
		(LEN(@BrandName) = 0 OR b.BrandName like '%' + @BrandName + '%') and
		(@Disabled = 1 OR a.Disabled=0)
Order by a.Name

END
GO
