Use econet;

CREATE TABLE IF NOT EXISTS userlocation(
	UserLocationId INT NOT NULL AUTO_INCREMENT ,
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
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (UserLocationId),
		CONSTRAINT FK_UserLocation_1 FOREIGN KEY (UserId) REFERENCES user(UserId) ON DELETE CASCADE, 
		CONSTRAINT FK_UserLocation_2 FOREIGN KEY (CountryId) REFERENCES country(CountryId) ON DELETE CASCADE 
);


call rheem.CreateIndexIfNotExists('econet', 'UserLocation_idx1', 'userlocation', 'UserId', null);
