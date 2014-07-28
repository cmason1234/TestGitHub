Use rheem;

CREATE TABLE IF NOT EXISTS ru_productcertification(
	ProductCertificationID varchar(64) NOT NULL,
	ProductID varchar(64) NOT NULL,
	CertificationID varchar(64) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ProductCertificationID)
);

