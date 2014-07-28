Use rheem;

CREATE TABLE IF NOT EXISTS ru_country(
	CountryID varchar(64) NOT NULL,
	Country varchar(50) NULL,
	CountryCode varchar(2) NOT NULL,
	Disabled bit NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (CountryID)
);

