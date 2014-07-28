USE [rheemnews]
GO

/****** Object:  StoredProcedure [dbo].[GetcoolZoneContentByID]    Script Date: 02/22/2012 15:57:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetcoolZoneContentByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetcoolZoneContentByID]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetcoolZoneContentByID]
(
	@coolZoneContentID int

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[coolZoneContentID], [pageTitle], [pageContent], [brand], display
	FROM coolZoneContent
	WHERE [coolZoneContentID] = @coolZoneContentID

	Set @Err = @@Error

	RETURN @Err
End

GO


