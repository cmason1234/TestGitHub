USE [RCN]
GO
/****** Object:  StoredProcedure [dbo].[GetDocumentByID]    Script Date: 11/18/2010 13:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    GetDocumentByID
   
   Description:  Selects record(s) from table 'Document'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 10:27:01 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetDocumentByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE GetDocumentByID;
		PRINT 'Dropped GetDocumentByID'
	END
GO
CREATE PROCEDURE [dbo].[GetDocumentByID]
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
