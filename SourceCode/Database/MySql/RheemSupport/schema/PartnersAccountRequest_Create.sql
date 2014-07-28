USE support;

DROP TABLE IF EXISTS partnersaccountrequest;

CREATE TABLE IF NOT EXISTS partnersaccountrequest (
    PartnersAccountRequestId int(11) NOT NULL AUTO_INCREMENT,
	Email varchar(255) NOT NULL,
	FirstName varchar(255) NOT NULL,
	LastName varchar(255) NOT NULL,
	AddressLine1 varchar(255) NOT NULL,
	AddressLine2 varchar(255) NULL,
	City varchar(255) NOT NULL,
	State varchar(2) NOT NULL,
	PostalCode varchar(10) NOT NULL,
	Country varchar(2) NOT NULL,
	Phone varchar(32) NOT NULL,
	WebSiteSendingRequest varchar(255) NOT NULL,
	CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
	PRIMARY KEY (PartnersAccountRequestId),
	UNIQUE INDEX partnersaccountrequest_idx1 (Email)
);
