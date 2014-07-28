USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[DeletetopContent]    Script Date: 11/18/2010 13:08:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    DeletetopContent
   
   Description:  Deletes a record from table 'topContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/26/2010 11:07:58 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeletetopContent') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE DeletetopContent;
		PRINT 'Dropped DeletetopContent'
	END
GO
CREATE PROCEDURE [dbo].[DeletetopContent]
(
	@topContentID int

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM snarkpub_user.topContent 
	WHERE [topContentID] = @topContentID
		

	Set @Err = @@Error

	RETURN @Err
End
GO
