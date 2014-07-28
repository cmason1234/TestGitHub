USE [rheemnews]
GO
/****** Object:  StoredProcedure [dbo].[GetCriticalAlertsNotConfirmedByPerson]    Script Date: 04/13/2011 13:57:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    GetCriticalAlertsNotConfirmedByPerson
   
   Description:  Selects critical alerts not confirmed
   
   AUTHOR:       Rheem Manufacturing, Brian White - 4/13/2011 8:52:06 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetCriticalAlertsNotConfirmedByPerson') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE GetCriticalAlertsNotConfirmedByPerson;
		PRINT 'Dropped GetCriticalAlertsNotConfirmedByPerson'
	END
GO
CREATE PROCEDURE [dbo].[GetCriticalAlertsNotConfirmedByPerson]
(
@PersonID uniqueidentifier
)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	SELECT  dbo.blogEntry.blogEntryID, dbo.blogEntry.entryDate, dbo.blogEntry.entryPersonID, 
	dbo.blogEntry.entryTitle, dbo.blogEntry.frontPageText, dbo.blogEntry.live, dbo.blogEntry.entryType, 
	dbo.blogEntry.expireDate, dbo.blogEntry.noIcon, dbo.blogEntry.isFullPage, dbo.blogEntry.fullPageText, 
	dbo.blogEntry.goLiveDate, dbo.blogEntry.entryBrandName, dbo.blogEntry.Parts, 
	dbo.blogEntry.PartsShowToDealers, dbo.blogEntry.PartsPriority, dbo.blogEntryCategories.roleCategory
	FROM  dbo.blogEntry INNER JOIN
	dbo.blogEntryCategories ON dbo.blogEntry.blogEntryID = dbo.blogEntryCategories.blogEntryID
	WHERE (dbo.blogEntry.live = 'True') 
	AND (dbo.blogEntry.expireDate > GETDATE()) 
	AND (dbo.blogEntry.goLiveDate <= GETDATE()) 
	AND (dbo.blogEntry.entryType = 'Critical')
	AND (dbo.blogEntry.blogEntryID NOT IN (
		SELECT blogEntryID
		FROM blogCriticalConfirmed
		WHERE PersonID = @PersonID
	))

	Set @Err = @@Error

	RETURN @Err
End
