Use rheem;

CREATE TABLE IF NOT EXISTS ru_productmodel(
	ProductModelID varchar(64) NOT NULL,
	ProductID varchar(64) NOT NULL,
	RPS_ID int NOT NULL,
	RPS_Model varchar(50) NOT NULL,
	RPS_Voltage int NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	PRIMARY KEY (ProductModelID)
);

