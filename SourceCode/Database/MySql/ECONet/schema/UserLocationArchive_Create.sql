Use econet;

CREATE TABLE IF NOT EXISTS userlocationarchive(
	UserLocationId INT,
	UserId INT NOT NULL,
	AddressLine1 varchar(50) NOT NULL,
	AddressLine2 varchar(50) NULL,
	City varchar(50) NOT NULL,
	State varchar(50) not NULL,
	PostalCode varchar(50) NULL,
	CountryId INT NOT NULL,
	LocationName varchar(50) NOT NULL,
	TimeZone varchar(50) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
    PRIMARY KEY (UserLocationId)
);

