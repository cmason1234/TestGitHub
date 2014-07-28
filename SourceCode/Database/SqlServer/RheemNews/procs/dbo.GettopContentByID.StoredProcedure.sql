USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[GettopContentByID]    Script Date: 11/18/2010 13:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    GettopContentByID
   
   Description:  Selects record(s) from table 'topContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/26/2010 11:07:58 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GettopContentByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE GettopContentByID;
		PRINT 'Dropped GettopContentByID'
	END
GO
CREATE PROCEDURE [dbo].[GettopContentByID]
(
	@topContentID int

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[topContentID], [pageTitle], [linkTitle], [pageContent], [brand]
	FROM snarkpub_user.topContent
	WHERE [topContentID] = @topContentID

	Set @Err = @@Error

	RETURN @Err
End
GO
