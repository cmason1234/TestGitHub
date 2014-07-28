USE [RCN]
GO
/****** Object:  StoredProcedure [dbo].[SearchDocumentAndSectionByString]    Script Date: 11/18/2010 13:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    SearchDocumentAndSectionByString
   
   Description:  Selects a record from table 'Document'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 10:27:01 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchDocumentAndSectionByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE SearchDocumentAndSectionByString;
		PRINT 'Dropped SearchDocumentAndSectionByString'
	END
GO
CREATE PROCEDURE [dbo].[SearchDocumentAndSectionByString]
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	SELECT DISTINCT DocumentNumber 
	FROM Section LEFT JOIN Document ON Section.DocumentID = Document.DocumentID 
	WHERE ' +  @searchParam

	EXEC(@strSql)
	
	--//We should NOT be using exec above.
	--//If params are NOT known, then be sure to clean sql
	--//If params are known, format like example below
	
	--IF @prodname IS NOT NULL
	--SELECT @sql = @sql + ' ProductName LIKE @prodname'
	--EXEC sp_executesql @sql, N'@prodname varchar(400)',@prodname
End
GO
