USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[DeletecontractorContent]    Script Date: 11/18/2010 13:08:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    DeletecontractorContent
   
   Description:  Deletes a record from table 'contractorContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 7:52:06 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeletecontractorContent') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE DeletecontractorContent;
		PRINT 'Dropped DeletecontractorContent'
	END
GO
CREATE PROCEDURE [dbo].[DeletecontractorContent]
(
	@contractorContentID int

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM snarkpub_user.contractorContent
	WHERE [contractorContentID] = @contractorContentID
		

	Set @Err = @@Error

	RETURN @Err
End
GO
