USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[InsertspecialPages]    Script Date: 11/18/2010 13:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    InsertspecialPages
   
   Description:  Inserts a record into table 'specialPages'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 12:14:18 PM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertspecialPages') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE InsertspecialPages;
		PRINT 'Dropped InsertspecialPages'
	END
GO
CREATE PROCEDURE [dbo].[InsertspecialPages]
(
	@specialPageID int = null output,
	@pageContent text = null, 
	@pageTitle varchar(250) = null, 
	@entryDate datetime, 
	@entryPersonID uniqueidentifier
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	

	INSERT
	INTO [specialPages]
	(
		[pageContent], 
		[pageTitle], 
		[entryDate], 
		[entryPersonID]
	)
	VALUES
	(
		@pageContent, 
		@pageTitle, 
		@entryDate, 
		@entryPersonID

	)

	SET @Err = @@Error
	SET @specialPageID = @@identity


	RETURN @Err
End
GO
