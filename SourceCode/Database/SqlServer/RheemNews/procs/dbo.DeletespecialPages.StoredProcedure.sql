USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[DeletespecialPages]    Script Date: 11/18/2010 13:08:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    DeletespecialPages
   
   Description:  Deletes a record from table 'specialPages'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 12:14:18 PM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeletespecialPages') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE DeletespecialPages;
		PRINT 'Dropped DeletespecialPages'
	END
GO
CREATE PROCEDURE [dbo].[DeletespecialPages]
(
	@specialPageID int

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [specialPages] 
	WHERE [specialPageID] = @specialPageID
		

	Set @Err = @@Error

	RETURN @Err
End
GO
