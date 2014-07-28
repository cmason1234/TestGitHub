USE rheem;

DROP PROCEDURE IF Exists CreateForeignKeyIfNotExists;

DELIMITER $$
CREATE PROCEDURE CreateForeignKeyIfNotExists (
     in schemaName varchar(128) -- If null use name of current schema;
	,in foreignKeyName varchar(128) -- If null an exception will be thrown.
	,in tableName varchar(128) -- If Null an exception will be thrown.
	,in ColName varchar(128) -- If null an exception will be thrown.
	,in extTableName varchar(128) -- if null an exception will be thrown.
	,in extColumnName varchar(1024) -- E.g. 'BrandID'
	,in ifPresent enum('leaveUnchanged', 'dropAndReplace') -- null=leaveUnchanged
	,in referenceOption varchar(128)  -- e.g. 'ON DELETE CASCADE
  )
BEGIN
	DECLARE doDrop tinyint(1) DEFAULT NULL;
	DECLARE doAdd tinyint(1) DEFAULT NULL;
	DECLARE tmpSql VARCHAR(4096) DEFAULT '';

	set schemaName = coalesce(schemaName, schema());
	set ifPresent = coalesce(ifPresent, 'leaveUnchanged');
	set referenceOption = coalesce(referenceOption, '');
	if exists
	( SELECT * 
      	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	    WHERE CONSTRAINT_SCHEMA = schemaName
  		  AND CONSTRAINT_NAME = foreignKeyName
	     AND CONSTRAINT_TYPE = 'FOREIGN KEY'
	) then
		if (ifPresent = 'leaveUnchanged') then
			set doDrop = 0;
			set doAdd = 0;
		elseif (ifPresent = 'dropAndReplace') then
			set doDrop = 1;
			set doAdd = 1;
		end if;
	else
		set doDrop = 0;
		set doAdd = 1;
	end if;

	if (doDrop = 1) then
		set tmpSql = concat( 'alter table `', schemaName, '`.`', tableName, '` DROP FOREIGN KEY `', foreignKeyName, '` ');
		set @sql = tmpSql;
		prepare tmp_stmt from @sql;
		execute tmp_stmt;
		deallocate prepare tmp_stmt;
	end if;

	if (doAdd = 1) then
		set tmpSql = concat( 'alter table `', schemaName, '`.`', tableName, '` ADD CONSTRAINT `', foreignKeyName, '` FOREIGN KEY (', ColName, ') REFERENCES `', extTableName, '`(`', extColumnName, '`) ', referenceOption );
		set @sql = tmpSql;
		prepare tmp_stmt from @sql;
		execute tmp_stmt;
		deallocate prepare tmp_stmt;
	end if;

END; $$
DELIMITER ;


