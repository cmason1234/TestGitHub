USE [rheemusers]
GO
/****** Object:  StoredProcedure [dbo].[SearchDidYouKnowByStringForSite]    Script Date: 05/25/2011 11:16:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    SearchDidYouKnowByStringForSite
   
   Description:  Selects a record from table 'DidYouKnow'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 5/24/2011 8:29:47 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchDidYouKnowByStringForSite') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE SearchDidYouKnowByStringForSite;
		PRINT 'Dropped SearchDidYouKnowByStringForSite'
	END
GO
CREATE PROCEDURE [dbo].[SearchDidYouKnowByStringForSite]
(
	@RheemWebsiteID varchar(50),
	@searchParam varchar(500),
	@TopRows int
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	IF @TopRows = '0'
	BEGIN
		SET @strSql = '	SELECT DidYouKnow.DidYouKnowID, DidYouKnow.DidYouKnowText, 
		DidYouKnow.DidYouKnowTitle
		FROM dbo.DidYouKnowSiteList INNER JOIN
        DidYouKnow ON DidYouKnowSiteList.DidYouKnowID = DidYouKnow.DidYouKnowID
		WHERE RheemWebsiteID = ''' + @RheemWebsiteID + ''' And ' +  @searchParam
	END
	
	IF @TopRows != '0'
	BEGIN
		SET @strSql = 'SELECT TOP (' + CAST(@TopRows as varchar(10)) + ') DidYouKnow.DidYouKnowID, DidYouKnow.DidYouKnowText, 
		DidYouKnow.DidYouKnowTitle
		FROM dbo.DidYouKnowSiteList INNER JOIN
        DidYouKnow ON DidYouKnowSiteList.DidYouKnowID = DidYouKnow.DidYouKnowID
		WHERE RheemWebsiteID = ''' + @RheemWebsiteID + ''' And ' +  @searchParam
	END
	

	EXEC(@strSql)

End
