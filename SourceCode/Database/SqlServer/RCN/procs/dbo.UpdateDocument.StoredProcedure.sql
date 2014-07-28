USE [RCN]
GO
/****** Object:  StoredProcedure [dbo].[UpdateDocument]    Script Date: 11/18/2010 13:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    UpdateDocument
   
   Description:  Updates a record In table 'Document'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 10:27:01 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateDocument') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE UpdateDocument;
		PRINT 'Dropped UpdateDocument'
	END
GO
CREATE PROCEDURE [dbo].[UpdateDocument]
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
