Use rheem;

CREATE TABLE IF NOT EXISTS ru_listemailaddress(
	ListEmailAddressID varchar(64) NOT NULL,
	ListID varchar(64) NOT NULL,
	EmailAddress varchar(50) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ListEmailAddressID)
);
