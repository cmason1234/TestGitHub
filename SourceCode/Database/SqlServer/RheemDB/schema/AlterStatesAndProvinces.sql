Use [RheemDB]
GO

IF NOT EXISTS(
      SELECT col.name FROM sys.indexes ind INNER JOIN sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id INNER JOIN sys.columns col     ON ic.object_id = col.object_id and ic.column_id = col.column_id 
        WHERE ind.name='UK_StateAndProvinces' AND ind.object_id = OBJECT_ID('StateAndProvinces') AND col.name='StateOrProvince'
    )
BEGIN
		Create Unique Index [UK_StateAndProvinces] ON
		     StateAndProvinces (StateOrProvince)
END
GO


