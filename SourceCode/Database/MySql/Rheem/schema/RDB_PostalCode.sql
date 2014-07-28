Use rheem;

CREATE TABLE IF NOT EXISTS rdb_postalcode(
    postalCodeID int(11) NOT NULL AUTO_INCREMENT,
	CountryName varchar(50) NULL,
	PostalCode varchar(50) NULL,
	PostalType varchar(50) NULL,
	City varchar(50) NULL,
	CityType varchar(50) NULL,
	County varchar(50) NULL,
	CountyFIPS varchar(50) NULL,
	ProvinceName varchar(50) NULL,
	StateOrProvinceCode varchar(50) NULL,
	StateFIPS varchar(50) NULL,
	MSACode varchar(50) NULL,
	AreaCode varchar(50) NULL,
	TimeZone varchar(50) NULL,
	UTC varchar(50) NULL,
	DST varchar(50) NULL,
	Latitude varchar(50) NULL,
	Longitude varchar(50) NULL,
	Lat float NULL,
	Lon float NULL,
	Primary Key(postalCodeID),
	INDEX idx_PostalCode1 (PostalCode),
    INDEX idx_PostalCode2 (Lat, Lon),
    INDEX idx_PostalCode3 (Latitude, Longitude)
);

	
