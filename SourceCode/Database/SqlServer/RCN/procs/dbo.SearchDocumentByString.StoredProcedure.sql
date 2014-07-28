USE [RCN]
GO
/****** Object:  StoredProcedure [dbo].[SearchDocumentByString]    Script Date: 11/18/2010 13:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    SearchDocumentByString
   
   Description:  Selects a record from table 'Document'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 10:27:01 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchDocumentByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE SearchDocumentByString;
		PRINT 'Dropped SearchDocumentByString'
	END
GO
CREATE PROCEDURE [dbo].[SearchDocumentByString]
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	-- DocumentSrc was cast because the dataset was getting to big 
	
	SET @strSql = '	Select 	[DocumentID], [DocumentTitle], [DocumentNumber], [Category], [Distribution], [PublicationDate], [UploadDate], [Keywords], [Abstract], [Filename], [MimeTypeOLD], [ByteCount], cast(DocumentTitle as image) as DocumentSrc, [Hot], [MimeType]
	FROM [Document]
	WHERE ' +  @searchParam

	EXEC(@strSql)
	
	--//We should NOT be using exec above.
	--//If params are NOT known, then be sure to clean sql
	--//If params are known, format like example below
	
	--IF @prodname IS NOT NULL
	--SELECT @sql = @sql + ' ProductName LIKE @prodname'
	--EXEC sp_executesql @sql, N'@prodname varchar(400)',@prodname
End
GO
