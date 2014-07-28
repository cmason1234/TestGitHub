USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[InserttopContent]    Script Date: 11/18/2010 13:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    InserttopContent
   
   Description:  Inserts a record into table 'topContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/26/2010 11:07:58 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InserttopContent') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE InserttopContent;
		PRINT 'Dropped InserttopContent'
	END
GO
CREATE PROCEDURE [dbo].[InserttopContent]
(
	@topContentID int = null output,
	@pageTitle varchar(250) = null, 
	@linkTitle varchar(50) = null, 
	@pageContent text = null, 
	@brand varchar(50) = null
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	

	INSERT
	INTO snarkpub_user.topContent
	(
		[pageTitle], 
		[linkTitle], 
		[pageContent], 
		[brand]
	)
	VALUES
	(
		@pageTitle, 
		@linkTitle, 
		@pageContent, 
		@brand

	)

	SET @Err = @@Error
	SET @topContentID = @@identity


	RETURN @Err
End
GO
