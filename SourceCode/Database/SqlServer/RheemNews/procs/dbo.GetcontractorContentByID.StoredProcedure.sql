USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[GetcontractorContentByID]    Script Date: 11/18/2010 13:08:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    GetcontractorContentByID
   
   Description:  Selects record(s) from table 'contractorContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 7:52:06 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetcontractorContentByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE GetcontractorContentByID;
		PRINT 'Dropped GetcontractorContentByID'
	END
GO
CREATE PROCEDURE [dbo].[GetcontractorContentByID]
(
	@contractorContentID int

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[contractorContentID], [pageTitle], [pageContent], [brand], [category]
	FROM snarkpub_user.contractorContent
	WHERE [contractorContentID] = @contractorContentID

	Set @Err = @@Error

	RETURN @Err
End
GO
