Use rheem;

CREATE TABLE IF NOT EXISTS ru_apimaster(
	APIMasterID varchar(36) NOT NULL,
	APIName varchar(50) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (APIMasterID)
);
