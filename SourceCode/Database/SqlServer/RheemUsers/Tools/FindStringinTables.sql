/*
    This stored procedure is used to search for strings within
	a given database and table.  The way to call it is:
	EXEC	FindStringInTables
		@stringToFind = N'216.122.22.11',
		@schema = rcn,
		@table = Product,
		@CountOnly if set to 1 only the counts of items found gets returned.
	From within the RheemUsers database, this will search the string 216.122.22.11
	within the rcn database and the Product table.
	The rows which have the requested string in them will be returned.
*/


USE [rheemusers] 
GO 


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FindStringInTables]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[FindStringInTables]
GO


CREATE PROCEDURE FindStringInTables @stringToFind VARCHAR(100), @schema sysname, @table sysname, @CountOnly bit
AS 

DECLARE @sqlCommand VARCHAR(8000) 
DECLARE @where VARCHAR(8000) 
DECLARE @columnName sysname 
DECLARE @cursor VARCHAR(8000) 

BEGIN TRY 
   if @CountOnly = 1
     SET @sqlCommand = 'SELECT COUNT(1), ''' + @table + ''' FROM ' + @schema + '.dbo.' + @table + ' WHERE'
   else
     SET @sqlCommand = 'SELECT * FROM ' + @schema + '.dbo.' + @table + ' WHERE' 

   SET @where = '' 

   SET @cursor = 'DECLARE col_cursor CURSOR FOR SELECT COLUMN_NAME 
   FROM ' + @schema + '.INFORMATION_SCHEMA.COLUMNS 
   WHERE TABLE_NAME = ''' + @table + ''' 
   AND DATA_TYPE IN (''char'',''nchar'',''ntext'',''nvarchar'',''text'',''varchar'')' 


   print @cursor
   EXEC (@cursor) 

   OPEN col_cursor    
   FETCH NEXT FROM col_cursor INTO @columnName    

   WHILE @@FETCH_STATUS = 0    
   BEGIN    
       IF @where <> '' 
           SET @where = @where + ' OR' 

       SET @where = @where + ' ' + @columnName + ' LIKE ''%' + @stringToFind + '%''' 
       FETCH NEXT FROM col_cursor INTO @columnName    
   END    

   CLOSE col_cursor    
   DEALLOCATE col_cursor  

   SET @sqlCommand = @sqlCommand + @where 
   PRINT @sqlCommand 
   EXEC (@sqlCommand)  
END TRY 
BEGIN CATCH 
   PRINT 'There was an error' 
   IF CURSOR_STATUS('variable', 'col_cursor') <> -3 
   BEGIN 
       CLOSE col_cursor    
       DEALLOCATE col_cursor  
   END 
END CATCH 
