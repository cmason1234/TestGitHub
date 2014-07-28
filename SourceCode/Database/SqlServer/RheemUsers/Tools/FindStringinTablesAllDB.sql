/*
    This stored procedure is used to search for strings within
	a given database and table.  The way to call it is:
	EXEC	FindStringInTablesAllDB
		@stringToFind = N'216.122.22.11',
		@schema = rcn
	From within the RheemUsers database, this will search the string 216.122.22.11
	within the rcn database and any Table it finds.
	The rows which have the requested string in them will be returned.
*/


USE [rheemusers] 
GO 


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FindStringInTablesAllDB]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[FindStringInTablesAllDB]
GO


CREATE PROCEDURE FindStringInTablesAllDB @stringToFind VARCHAR(100), @schema sysname 
AS 

DECLARE @sqlCommand VARCHAR(8000) 
DECLARE @where VARCHAR(8000) 
DECLARE @tableName sysname 
DECLARE @cursor VARCHAR(8000) 

BEGIN TRY 

   SET @cursor = 'DECLARE TBL_CURSOR CURSOR FOR SELECT TABLE_NAME 
   FROM ' + @schema + '.INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = ''BASE TABLE''
   ORDER BY TABLE_NAME' 

   print @cursor
   EXEC (@cursor) 

   OPEN TBL_CURSOR    
   FETCH NEXT FROM TBL_CURSOR INTO @tableName    

   WHILE @@FETCH_STATUS = 0    
   BEGIN    
       EXEC FindStringInTables @stringToFind, @schema, @tableName, 1
       FETCH NEXT FROM TBL_CURSOR INTO @tableName    
   END    

   CLOSE TBL_CURSOR    
   DEALLOCATE TBL_CURSOR  

END TRY 
BEGIN CATCH 
   PRINT 'There was an error' 
   IF CURSOR_STATUS('variable', 'TBL_CURSOR') <> -3 
   BEGIN 
       CLOSE TBL_CURSOR    
       DEALLOCATE TBL_CURSOR  
   END 
END CATCH 
