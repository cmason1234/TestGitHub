USE rheem;

Call AddColumnIfNotExists(null, 'ru_producttag', 'Name', 'varchar(256) NULL');
Call AddColumnIfNotExists(null, 'ru_producttag', 'Description', 'varchar(512) NULL');
Call AddColumnIfNotExists(null, 'ru_producttag', 'LogoURL', 'varchar(550) NULL');
