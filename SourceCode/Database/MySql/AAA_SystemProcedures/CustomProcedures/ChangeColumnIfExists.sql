USE rheem;

drop procedure if exists ChangeColumnIfExists;

delimiter $$
create procedure ChangeColumnIfExists(
    IN schemaName varchar(128), -- If null use name of current schema;
	IN tableName tinytext,
	IN fieldName tinytext,
	IN fieldNameNew tinytext,
	IN fieldDef text)
begin
	set schemaName = coalesce(schemaName, schema());

	IF EXISTS (
		SELECT * FROM information_schema.COLUMNS
		WHERE column_name=fieldName
		and table_name=tableName
		and table_schema=schemaName
		)
	THEN
		set @ddl=CONCAT('ALTER TABLE ',schemaName,'.',tableName,
			' CHANGE COLUMN ',fieldName,' ',fieldNameNew, ' ',fieldDef);
		prepare stmt from @ddl;
		execute stmt;
	END IF;
end; $$

delimiter ';'