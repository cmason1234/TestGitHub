Use rheem;

CREATE TABLE IF NOT EXISTS ru_certification(
	CertificationID varchar(64) NOT NULL,
	DisplayName varchar(50) NOT NULL,
	ExternalURL varchar(256) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	Description longtext NULL,
    PRIMARY KEY (CertificationID)
);

