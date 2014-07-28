USE [Products]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDocumentControlsForProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDocumentControlsForProduct]


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
CREATE PROCEDURE [dbo].[GetDocumentControlsForProduct] 
    -- Add the parameters for the stored procedure here
    @ProductID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    DECLARE @ProductCategoryID uniqueidentifier, @SeriesID uniqueidentifier
	
	SELECT @ProductCategoryID=ProductCategoryID, @SeriesID=SeriesID FROM Product WHERE ProductID=@ProductID
	
	SELECT d.*, pd.PairingType, pd.ProductDocumentID as TableDocumentID 
        FROM products..ProductDocument pd 
		INNER JOIN rcn..document d ON pd.documentid = d.documentid 
       WHERE pd.productID=@ProductID
     ORDER BY Filename
	
	SELECT d.*,  pcd.PairingType, pcd.ProductCategoryDocumentID as TableDocumentID 
      FROM products..ProductCategoryDocument pcd
	   INNER JOIN rcn..document d ON   pcd.documentid = d.documentid 
       WHERE pcd.ProductCategoryID=@ProductCategoryID
     ORDER BY fileName

    SELECT d.*, sd.PairingType, sd.SeriesDocumentID as TableDocumentID
      FROM 
       products..SeriesDocument sd
	   INNER JOIN rcn..document d ON sd.documentid = d.documentid  
       WHERE sd.SeriesID=@SeriesID
     ORDER BY fileName
  
END
GO
