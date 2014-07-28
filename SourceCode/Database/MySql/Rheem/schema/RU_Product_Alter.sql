USE rheem;

Call AddColumnIfNotExists(null, 'ru_product', 'WarrantyRegistrationBit',  'bit NOT NULL DEFAULT 0');
Call AddColumnIfNotExists(null, 'ru_product', 'WarrantyRegistrationInstallationTime',  'int NOT NULL DEFAULT 0');
Call AddColumnIfNotExists(null, 'ru_product', 'ProClubPoints',  'int NOT NULL DEFAULT 0');
Call AddColumnIfNotExists(null, 'ru_product', 'SeriesID',  'varchar(64) NULL');
Call AddColumnIfNotExists(null, 'ru_product', 'ProductCopy', 'longtext NULL');
Call AddColumnIfNotExists(null, 'ru_product', 'WarrantyText', 'longtext NULL');
Call AddColumnIfNotExists(null, 'ru_product', 'ReplacementProductID', 'varchar(64) NULL');
Call AddColumnIfNotExists(null, 'ru_product', 'Transitional', 'bit NOT NULL DEFAULT 0');
Call AddColumnIfNotExists(null, 'ru_product', 'Market', 'varchar(1) NOT NULL DEFAULT ''U''');

Call DropColumnIfExists(null, 'ru_product', 'WarrantyRegistrationMsg');

alter table ru_product modify Model VARCHAR(256);

Call AddColumnIfNotExists(null, 'ru_product', 'EconetEnabled', 'bit NOT NULL DEFAULT 0');

Call AddColumnIfNotExists(null, 'ru_product', 'ProductLiteratureDirtyAPI', 'bit NOT NULL DEFAULT 0');
Call AddColumnIfNotExists(null, 'ru_product', 'PTSURL', 'varchar(550) NULL');
