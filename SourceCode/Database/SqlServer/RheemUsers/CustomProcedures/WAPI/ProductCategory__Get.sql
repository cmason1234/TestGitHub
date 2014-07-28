USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WAPI__ProductCategory__Get]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WAPI__ProductCategory__Get]
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
CREATE PROCEDURE [dbo].[WAPI__ProductCategory__Get] 
    -- Add the parameters for the stored procedure here
	@CategoryName varchar(200),
	@ProductCategoryID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	if @ProductCategoryID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) set @ProductCategoryID = null

    SELECT ProductCategoryID, CategoryName
	FROM rheemusers..ProductCategory
	WHERE (LEN(@CategoryName) = 0 OR CategoryName like @CategoryName) and
          (@ProductCategoryID IS NULL OR ProductCategoryID=@ProductCategoryID)
	ORDER BY CategoryName

END
GO
