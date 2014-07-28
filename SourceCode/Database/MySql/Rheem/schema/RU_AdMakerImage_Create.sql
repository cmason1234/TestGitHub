Use rheem;

CREATE TABLE IF NOT EXISTS ru_admakerimage(
	AdMakerImageID varchar(64) NOT NULL,
	BrandID varchar(64) NOT NULL,
	Name varchar(50) NOT NULL,
	ImageType varchar(50) NOT NULL,
	ImageUrl varchar(250) NOT NULL,
	PageSize varchar(50) NOT NULL,
	AssetCategory varchar(50) NOT NULL,
	BlackWhite bit NOT NULL,
	Disabled bit NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (AdMakerImageID)
);

call CreateIndexIfNotExists(NULL, 'admakerimage_idx1', 'ru_admakerimage', 'BrandID', NULL);
Call AddColumnIfNotExists(null, 'ru_admakerimage', 'HorizVert',  'varchar(1) NOT NULL DEFAULT ''X''');
