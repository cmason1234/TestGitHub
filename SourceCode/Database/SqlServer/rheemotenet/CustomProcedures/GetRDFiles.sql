USE [rheemotenet]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRDFiles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRDFiles]
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
CREATE PROCEDURE [dbo].[GetRDFiles] 
	-- Add the parameters for the stored procedure here
	@urlContains varchar(450),
	@fileNameContains varchar(450),
	@keywordsContains varchar(450),
	@keywordsNotContains varchar(450),
    @dateCheck date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT FileName, FileUrl, Keywords, Title, FileDateTime 
	  from PTSPDFList
	  WHERE
	    FileURL like @urlContains AND
		(len(@fileNameContains) = 0 OR FileName like @fileNameContains) AND
		(len(@keywordsContains) = 0 OR Keywords like @keywordsContains) AND
		(len(@keywordsNotContains) = 0 OR Keywords Not Like @keywordsNotContains) AND
		FileDateTime > @dateCheck
	ORDER BY FileName

END
GO
