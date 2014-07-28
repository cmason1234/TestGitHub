USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCloudPDFByText]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetCloudPDFByText]
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
CREATE PROCEDURE [dbo].[GetCloudPDFByText]
    -- Add the parameters for the stored procedure here
    @searchParam varchar(4000)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
	
    -- Insert statements for procedure here
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)
    
    if LEN(@searchParam) = 0 set @searchParam='1=0'

    SET @strSql = ' SELECT cd.CloudDocumentID, ObjectID, ObjectType, DocumentTitle, DocumentNumber, ObjectDocumentNumber, 
	     FriendlyName, Abstract, Disabled, UploadedFileName, CloudFileName, CloudBucket, FileExtension,
		 cd.DocumentTypeID, TypeName, cdt.PageNumber, cdt.SearchableText
    FROM CloudDocument cd
	    INNER JOIN CloudDocumentSearchableText cdt on cd.CloudDocumentID=cdt.CloudDocumentID
        INNER JOIN DocumentType dt ON cd.DocumentTypeID=dt.DocumentTypeID
    WHERE ' +  @searchParam +
	' ORDER BY DocumentTitle, cdt.PageNumber'

    EXEC(@strSql)


END
GO
