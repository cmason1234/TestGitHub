USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[InsertcontractorContent]    Script Date: 11/18/2010 13:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    InsertcontractorContent
   
   Description:  Inserts a record into table 'contractorContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 7:52:06 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertcontractorContent') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE InsertcontractorContent;
		PRINT 'Dropped InsertcontractorContent'
	END
GO
CREATE PROCEDURE [dbo].[InsertcontractorContent]
(
	@contractorContentID int = null output,
	@pageTitle varchar(250) = null, 
	@pageContent text = null, 
	@brand varchar(50) = null, 
	@category varchar(50) = null
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	

	INSERT
	INTO snarkpub_user.contractorContent
	(
		[pageTitle], 
		[pageContent], 
		[brand], 
		[category]
	)
	VALUES
	(
		@pageTitle, 
		@pageContent, 
		@brand, 
		@category

	)

	SET @Err = @@Error
	SET @contractorContentID = @@identity


	RETURN @Err
End
GO
