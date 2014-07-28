USE [RCN]
GO
/****** Object:  StoredProcedure [dbo].[InsertDocument]    Script Date: 11/18/2010 13:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    InsertDocument
   
   Description:  Inserts a record into table 'Document'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 10:27:01 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertDocument') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE InsertDocument;
		PRINT 'Dropped InsertDocument'
	END
GO
CREATE PROCEDURE [dbo].[InsertDocument]
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
