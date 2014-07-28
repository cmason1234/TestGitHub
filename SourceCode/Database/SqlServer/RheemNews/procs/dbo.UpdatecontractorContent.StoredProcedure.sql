USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[UpdatecontractorContent]    Script Date: 11/18/2010 13:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    UpdatecontractorContent
   
   Description:  Updates a record In table 'contractorContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 7:52:06 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdatecontractorContent') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE UpdatecontractorContent;
		PRINT 'Dropped UpdatecontractorContent'
	END
GO
CREATE PROCEDURE [dbo].[UpdatecontractorContent]
(
	@contractorContentID int, 
	@pageTitle varchar(250), 
	@pageContent text, 
	@brand varchar(50), 
	@category varchar(50)

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE snarkpub_user.contractorContent
	SET
	[pageTitle] = @pageTitle, 
	[pageContent] = @pageContent, 
	[brand] = @brand, 
	[category] = @category

	WHERE [contractorContentID] = @contractorContentID

	Set @Err = @@Error

	RETURN @Err
End
GO
