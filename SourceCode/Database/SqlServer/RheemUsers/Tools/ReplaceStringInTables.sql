/*
    This stored procedure is used to search for strings within
	a given database and replace them.  The way to call it is:
	EXEC	ReplaceStringInTables
		@stringToFind = N'216.122.22.11',
		@stringToReplace = N'globalimageserver.com',
		@schema = rcn
	From within the RheemUsers database, this will search the string 216.122.22.11 and
	replace it with globalimageserver.com in all tables within the rcn database.
*/


USE [rheemusers] 
GO 


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReplaceStringInTables]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ReplaceStringInTables]
GO


CREATE PROCEDURE ReplaceStringInTables(@stringToFind VARCHAR(100), @stringToReplace VARCHAR(100), @schema sysname)
AS 



SET NOCOUNT ON 

DECLARE @count INT 
DECLARE @sqlCommand VARCHAR(8000) 
DECLARE @where VARCHAR(8000) 
DECLARE @table sysname
DECLARE @columnName sysname 
DECLARE @object_id INT 
DECLARE @cursor VARCHAR(8000) 
DECLARE @cursor2 VARCHAR(8000) 

set @cursor = 'DECLARE TAB_CURSOR CURSOR  FOR 
SELECT   A.NAME      AS TABLENAME, 
         A.OBJECT_ID 
FROM     ' + @schema + '.sys.objects A 
         INNER JOIN sys.schemas B 
           ON A.SCHEMA_ID = B.SCHEMA_ID 
WHERE    TYPE = ''U'' ORDER BY 2'

EXEC(@cursor)
          
OPEN TAB_CURSOR 

FETCH NEXT FROM TAB_CURSOR 
INTO @table, 
     @object_id 
      
WHILE @@FETCH_STATUS = 0 
  BEGIN 
    set @cursor2 = 'DECLARE COL_CURSOR CURSOR FOR 
      SELECT  COLUMN_NAME 
       FROM   ' + @schema + '.INFORMATION_SCHEMA.COLUMNS 
    WHERE  TABLE_NAME = ''' + @table + ''' 
   AND DATA_TYPE IN (''char'',''nchar'',''ntext'',''nvarchar'',''text'',''varchar'')' 

    EXEC(@cursor2)

    OPEN COL_CURSOR 
     
    FETCH NEXT FROM COL_CURSOR 
    INTO @columnName 
     
    WHILE @@FETCH_STATUS = 0 
      BEGIN 
        SET @sqlCommand = 'UPDATE ' + @schema + '.dbo.' + @table + ' SET [' + @columnName + '] = REPLACE(convert(nvarchar(max),[' + @columnName + ']),''' + @stringToFind + ''',''' + @stringToReplace + ''')' 
         
        SET @where = ' WHERE [' + @columnName + '] LIKE ''%' + @stringToFind + '%''' 
         
        EXEC( @sqlCommand + @where) 
         
        SET @count = @@ROWCOUNT 
         
        IF @count > 0 
          BEGIN 
            PRINT @sqlCommand + @where 
            PRINT 'Updated: ' + CONVERT(VARCHAR(10),@count) 
            PRINT '----------------------------------------------------' 
          END 
         
        FETCH NEXT FROM COL_CURSOR 
        INTO @columnName 
      END 
     
    CLOSE COL_CURSOR 
    DEALLOCATE COL_CURSOR 
     
    FETCH NEXT FROM TAB_CURSOR 
    INTO @table, 
         @object_id 
  END 
   
CLOSE TAB_CURSOR 
DEALLOCATE TAB_CURSOR 
