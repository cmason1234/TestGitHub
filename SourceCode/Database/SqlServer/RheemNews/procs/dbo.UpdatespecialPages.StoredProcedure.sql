USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[UpdatespecialPages]    Script Date: 11/18/2010 13:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    UpdatespecialPages
   
   Description:  Updates a record In table 'specialPages'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 12:14:18 PM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdatespecialPages') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE UpdatespecialPages;
		PRINT 'Dropped UpdatespecialPages'
	END
GO
CREATE PROCEDURE [dbo].[UpdatespecialPages]
(
	@specialPageID int, 
	@pageContent text, 
	@pageTitle varchar(250), 
	@entryDate datetime, 
	@entryPersonID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [specialPages]
	SET
	[pageContent] = @pageContent, 
	[pageTitle] = @pageTitle, 
	[entryDate] = @entryDate, 
	[entryPersonID] = @entryPersonID

	WHERE [specialPageID] = @specialPageID

	Set @Err = @@Error

	RETURN @Err
End
GO
