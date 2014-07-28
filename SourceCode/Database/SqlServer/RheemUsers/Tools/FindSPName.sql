CREATE PROCEDURE Find_SPName_With_Text
   @StringToSearch varchar(100)
AS
   SET @StringToSearch = '%' + @StringToSearch + '%'
   SELECT DISTINCT SO.NAME
   FROM SYSOBJECTS SO (NOLOCK)
   WHERE SO.TYPE = 'P'
   AND SO.NAME LIKE @StringToSearch
   ORDER BY SO.Name
GO

