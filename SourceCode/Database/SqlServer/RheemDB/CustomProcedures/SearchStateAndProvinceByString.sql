USE [rheemdb]
GO

/****** Object:  StoredProcedure [dbo].[SearchStateAndProvinceByString]    Script Date: 02/21/2011 13:47:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/* ------------------------------------------------------------
   PROCEDURE:    SearchStateAndProvinceByString
   
   Description:  Selects State And Provinces From 'StateAndProvinces'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 3:23:28 PM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchStateAndProvinceByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE SearchStateAndProvinceByString;
		PRINT 'Dropped SearchStateAndProvinceByString'
	END
GO
CREATE PROCEDURE [dbo].[SearchStateAndProvinceByString] 

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
    SELECT StateandProvinceID, StateOrProvinceName,
	StateOrProvince, Country
	FROM rheemdb..StateAndProvinces
    ORDER BY Country desc, StateOrProvinceName asc 
   	
END


GO

