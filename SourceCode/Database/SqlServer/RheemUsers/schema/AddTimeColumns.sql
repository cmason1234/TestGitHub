/*
   This sql script may be run against any of our databases, just by changing
   the Use statement at the top.  It will check for the existence of two columns
   CreateDateTime__Gen and UpdateDateTime__Gen.  If either doesn't exist they will be
   created, if the do exist, then they won't be created.  If they are created the create and
   update times are both set to be now.
*/
Use [RheemUsers]
GO

Declare @tableName as sysname
DECLARE @sqlCommand VARCHAR(8000)
Declare TableCursor CURSOR FAST_FORWARD FOR SELECT table_name FROM information_schema.tables where TABLE_TYPE='BASE TABLE' order by 1
OPEN TableCursor 
FETCH NEXT FROM TableCursor INTO @tableName WHILE @@FETCH_STATUS = 0
BEGIN
if NOT exists (select COLUMN_NAME from INFORMATION_SCHEMA.columns where
    table_name = @tableName and column_name = 'CreateDateTime__Gen')
   BEGIN
      set @sqlCommand ='Alter Table ' + @tableName + ' Add CreateDateTime__Gen DateTime'
      print @sqlCommand
      exec (@sqlCommand)
      
      set @sqlCommand = 'Update ' + @tableName + ' set CreateDateTime__Gen=SYSDATETIME()'
      print @sqlCommand
      exec (@sqlCommand)
   END   
      
if NOT exists (select COLUMN_NAME from INFORMATION_SCHEMA.columns where
    table_name = @tableName and column_name = 'UpdateDateTime__Gen')
   BEGIN
      set @sqlCommand ='Alter Table ' + @tableName + ' Add UpdateDateTime__Gen DateTime'
      print @sqlCommand
      exec (@sqlCommand)
      
      set @sqlCommand = 'Update ' + @tableName + ' set UpdateDateTime__Gen=SYSDATETIME()'
      print @sqlCommand
      exec (@sqlCommand)
   END   
FETCH NEXT FROM TableCursor INTO @tableName 
END
CLOSE TableCursor 
DEALLOCATE TableCursor

