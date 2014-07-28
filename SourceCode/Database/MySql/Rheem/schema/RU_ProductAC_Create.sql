Use rheem;

CREATE TABLE IF NOT EXISTS ru_productac(
	ProductACID varchar(64) NULL,
	ProductID   varchar(64) NULL,
	OutdoorUnitOnly  bit  NOT NULL,
	OutdoorUnitGas   bit  NOT NULL,
	OutdoorUnitAir   bit  NOT NULL,
	IndoorUnitOnly   bit  NOT NULL,
	PackageUnit      bit  NOT NULL,
	OutdoorUnitWithCoil   bit  NOT NULL,
	CreateDateTime__Gen   datetime  NULL,
	UpdateDateTime__Gen   datetime  NULL,
	GasEfficiency   float  NOT NULL,
    PRIMARY KEY (ProductACID)
);

call CreateIndexIfNotExists(null, 'productac_idx1', 'ru_productac', 'ProductID', null);


	
	