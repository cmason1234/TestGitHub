USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[UpdatetopContent]    Script Date: 11/18/2010 13:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    UpdatetopContent
   
   Description:  Updates a record In table 'topContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/26/2010 11:07:58 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdatetopContent') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE UpdatetopContent;
		PRINT 'Dropped UpdatetopContent'
	END
GO
CREATE PROCEDURE [dbo].[UpdatetopContent]
(
	@topContentID int, 
	@pageTitle varchar(250), 
	@linkTitle varchar(50), 
	@pageContent text, 
	@brand varchar(50)

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE snarkpub_user.topContent
	SET
	[pageTitle] = @pageTitle, 
	[linkTitle] = @linkTitle, 
	[pageContent] = @pageContent, 
	[brand] = @brand

	WHERE [topContentID] = @topContentID

	Set @Err = @@Error

	RETURN @Err
End
GO
