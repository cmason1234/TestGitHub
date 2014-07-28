USE rheem;

DROP PROCEDURE IF Exists DropForeignKeyIfExists;

DELIMITER $$
CREATE PROCEDURE DropForeignKeyIfExists (
     in schemaName varchar(128) -- If null use name of current schema;
	,in tableName varchar(128) -- If Null an exception will be thrown.
	,in foreignKeyName varchar(128) -- If null an exception will be thrown.
  )
BEGIN
	DECLARE tmpSql VARCHAR(4096) DEFAULT '';

	set schemaName = coalesce(schemaName, schema());
	if exists
	( SELECT * 
      	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	    WHERE CONSTRAINT_SCHEMA = schemaName
  		  AND CONSTRAINT_NAME = foreignKeyName
	     AND CONSTRAINT_TYPE = 'FOREIGN KEY'
	) then
		set tmpSql = concat( 'alter table `', schemaName, '`.`', tableName, '` DROP FOREIGN KEY `', foreignKeyName, '` ');
		set @sql = tmpSql;
		prepare tmp_stmt from @sql;
		execute tmp_stmt;
		deallocate prepare tmp_stmt;
	end if;


END; $$
DELIMITER ;


