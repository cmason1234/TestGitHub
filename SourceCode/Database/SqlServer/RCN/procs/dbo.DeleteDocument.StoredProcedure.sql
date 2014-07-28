USE [RCN]
GO
/****** Object:  StoredProcedure [dbo].[DeleteDocument]    Script Date: 11/18/2010 13:09:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    DeleteDocument
   
   Description:  Deletes a record from table 'Document'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 10:27:01 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteDocument') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE DeleteDocument;
		PRINT 'Dropped DeleteDocument'
	END
GO
CREATE PROCEDURE [dbo].[DeleteDocument]
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
