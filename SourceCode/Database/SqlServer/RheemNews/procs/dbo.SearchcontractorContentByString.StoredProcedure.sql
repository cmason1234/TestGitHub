USE [RheemNews]
GO
/****** Object:  StoredProcedure [dbo].[SearchcontractorContentByString]    Script Date: 11/18/2010 13:08:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    SearchcontractorContentByString
   
   Description:  Selects a record from table 'contractorContent'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 7:52:06 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchcontractorContentByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
	    DROP PROCEDURE SearchcontractorContentByString;
		PRINT 'Dropped SearchcontractorContentByString'
	END
GO
CREATE PROCEDURE [dbo].[SearchcontractorContentByString]
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[contractorContentID], [pageTitle], [pageContent], [brand], [category]
	FROM snarkpub_user.contractorContent
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
