USE rheem;

DROP PROCEDURE IF Exists CreateIndexIfNotExists;

DELIMITER $$
CREATE PROCEDURE CreateIndexIfNotExists (
     in schemaName varchar(128) -- If null use name of current schema;
	,in indexName varchar(128) -- If null an exception will be thrown.
	,in tableName varchar(128) -- If null an exception will be thrown.
	,in columnDefinition varchar(1024) -- E.g. 'BrandID'
	,in ifPresent enum('leaveUnchanged', 'dropAndReplace') -- null=leaveUnchanged
  )
BEGIN
	DECLARE doDrop tinyint(1) DEFAULT NULL;
	DECLARE doAdd tinyint(1) DEFAULT NULL;
	DECLARE tmpSql VARCHAR(4096) DEFAULT '';

	set schemaName = coalesce(schemaName, schema());
	set ifPresent = coalesce(ifPresent, 'leaveUnchanged');
	if exists
	( SELECT * 
      	FROM INFORMATION_SCHEMA.STATISTICS
	    WHERE table_schema = schemaName
  		  AND table_name = tableName
	     AND index_name = indexName
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
		set tmpSql = concat( 'alter table `', schemaName, '`.`', tableName, '` drop index `', indexName, '` ');
		set @sql = tmpSql;
		prepare tmp_stmt from @sql;
		execute tmp_stmt;
		deallocate prepare tmp_stmt;
	end if;

	if (doAdd = 1) then
		set tmpSql = concat( 'alter table `', schemaName, '`.`', tableName, '` add index `', indexName, '` (', columnDefinition, ')');
		set @sql = tmpSql;
		prepare tmp_stmt from @sql;
		execute tmp_stmt;
		deallocate prepare tmp_stmt;
	end if;

END; $$
DELIMITER ;


