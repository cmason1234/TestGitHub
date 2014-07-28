


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'Document'
   
   AUTHOR:       Brian White - 10/27/2010 10:27:01 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertDocument') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertDocument;
	 PRINT 'Dropped InsertDocument'
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertDocument
   
   Description:  Inserts a record into table 'Document'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 10:27:01 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertDocument
(
	@DocumentID uniqueidentifier = null output,
	@DocumentTitle varchar(256) = null, 
	@DocumentNumber varchar(256) = null, 
	@Category varchar(50) = null, 
	@Distribution char(10) = null, 
	@PublicationDate datetime, 
	@UploadDate datetime, 
	@Keywords varchar(2048) = null, 
	@Abstract text = null, 
	@Filename varchar(256) = null, 
	@MimeTypeOLD varchar(50) = null, 
	@ByteCount int, 
	@DocumentSrc image, 
	@Hot bit, 
	@MimeType varchar(512) = null
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @DocumentID = NewID()
	

	INSERT
	INTO [Document]
	(
		[DocumentID], 
		[DocumentTitle], 
		[DocumentNumber], 
		[Category], 
		[Distribution], 
		[PublicationDate], 
		[UploadDate], 
		[Keywords], 
		[Abstract], 
		[Filename], 
		[MimeTypeOLD], 
		[ByteCount], 
		[DocumentSrc], 
		[Hot], 
		[MimeType]
	)
	VALUES
	(
		@DocumentID, 
		@DocumentTitle, 
		@DocumentNumber, 
		@Category, 
		@Distribution, 
		@PublicationDate, 
		@UploadDate, 
		@Keywords, 
		@Abstract, 
		@Filename, 
		@MimeTypeOLD, 
		@ByteCount, 
		@DocumentSrc, 
		@Hot, 
		@MimeType

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertDocument Succeeded'
Else PRINT 'Procedure Creation: InsertDocument Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetDocumentByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetDocumentByID;
	 PRINT 'Dropped GetDocumentByID'
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetDocumentByID
   
   Description:  Selects record(s) from table 'Document'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 10:27:01 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetDocumentByID
(
	@DocumentID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[DocumentID], [DocumentTitle], [DocumentNumber], [Category], [Distribution], [PublicationDate], [UploadDate], [Keywords], [Abstract], [Filename], [MimeTypeOLD], [ByteCount], [DocumentSrc], [Hot], [MimeType]
	FROM [Document]
	WHERE [DocumentID] = @DocumentID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetDocumentByID Succeeded'
Else PRINT 'Procedure Creation: GetDocumentByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchDocumentByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchDocumentByString;
	 PRINT 'Dropped SearchDocumentByString'
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchDocumentByString
   
   Description:  Selects a record from table 'Document'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 10:27:01 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchDocumentByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[DocumentID], [DocumentTitle], [DocumentNumber], [Category], [Distribution], [PublicationDate], [UploadDate], [Keywords], [Abstract], [Filename], [MimeTypeOLD], [ByteCount], [DocumentSrc], [Hot], [MimeType]
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

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: SearchDocumentByString Succeeded'
Else PRINT 'Procedure Creation: SearchDocumentByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchDocumentAndSectionByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchDocumentAndSectionByString;
	 PRINT 'Dropped SearchDocumentAndSectionByString'
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchDocumentAndSectionByString
   
   Description:  Selects a record from table 'Document'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 10:27:01 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchDocumentAndSectionByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = 'SELECT DISTINCT DocumentNumber 
	FROM Section LEFT JOIN Document ON Section.DocumentID = Document.DocumentID 
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

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: SearchDocumentAndSectionByString Succeeded'
Else PRINT 'Procedure Creation: SearchDocumentAndSectionByString Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateDocument') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateDocument;
	 PRINT 'Dropped UpdateDocument'
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateDocument
   
   Description:  Updates a record In table 'Document'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 10:27:01 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateDocument
(
	@DocumentID uniqueidentifier, 
	@DocumentTitle varchar(256), 
	@DocumentNumber varchar(256), 
	@Category varchar(50), 
	@Distribution char(10), 
	@PublicationDate datetime, 
	@UploadDate datetime, 
	@Keywords varchar(2048), 
	@Abstract text, 
	@Filename varchar(256), 
	@MimeTypeOLD varchar(50), 
	@ByteCount int, 
	@DocumentSrc image, 
	@Hot bit, 
	@MimeType varchar(512)

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [Document]
	SET
	[DocumentID] = @DocumentID, 
	[DocumentTitle] = @DocumentTitle, 
	[DocumentNumber] = @DocumentNumber, 
	[Category] = @Category, 
	[Distribution] = @Distribution, 
	[PublicationDate] = @PublicationDate, 
	[UploadDate] = @UploadDate, 
	[Keywords] = @Keywords, 
	[Abstract] = @Abstract, 
	[Filename] = @Filename, 
	[MimeTypeOLD] = @MimeTypeOLD, 
	[ByteCount] = @ByteCount, 
	[DocumentSrc] = @DocumentSrc, 
	[Hot] = @Hot, 
	[MimeType] = @MimeType

	WHERE [DocumentID] = @DocumentID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateDocument Succeeded'
Else PRINT 'Procedure Creation: UpdateDocument Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteDocument') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteDocument;
	 PRINT 'Dropped DeleteDocument'
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteDocument
   
   Description:  Deletes a record from table 'Document'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 10:27:01 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteDocument
(
	@DocumentID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [Document] 
	WHERE [DocumentID] = @DocumentID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteDocument Succeeded'
Else PRINT 'Procedure Creation: DeleteDocument Error on Creation'
GO
		
		


