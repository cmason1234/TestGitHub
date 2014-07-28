USE support;

DROP TABLE IF EXISTS refreshtoken;

CREATE TABLE IF NOT EXISTS refreshtoken (
    RefreshTokenId int(11) NOT NULL AUTO_INCREMENT,
	ProviderRefreshToken varchar(255) NOT NULL,
	ClientID varchar(255) NOT NULL,
	Email varchar(255) NOT NULL,
	VerifiedEmail bit NOT NULL DEFAULT 0,
	Name varchar(510) NULL,
	GivenName varchar(255) NULL, 
	FamilyName varchar(255) NULL,
	link varchar(1024) NULL,
	picture varchar(1024) NULL,
	gender varchar(6) NULL,
	locale varchar(255) NULL,
	CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
	PRIMARY KEY (RefreshTokenId),
	UNIQUE INDEX refreshtoken_idx1 (ProviderRefreshToken),
	UNIQUE INDEX refreshtoken_idx2 (Email, ClientID)
);
