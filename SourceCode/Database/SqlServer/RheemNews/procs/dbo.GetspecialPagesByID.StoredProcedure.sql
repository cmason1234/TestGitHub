USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[GetspecialPagesByID]    Script Date: 11/18/2010 13:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    GetspecialPagesByID
   
   Description:  Selects record(s) from table 'specialPages'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 12:14:18 PM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetspecialPagesByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE GetspecialPagesByID;
		PRINT 'Dropped GetspecialPagesByID'
	END
GO
CREATE PROCEDURE [dbo].[GetspecialPagesByID]
(
	@specialPageID int

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[specialPageID], [pageContent], [pageTitle], [entryDate], [entryPersonID]
	FROM [specialPages]
	WHERE [specialPageID] = @specialPageID

	Set @Err = @@Error

	RETURN @Err
End
GO
