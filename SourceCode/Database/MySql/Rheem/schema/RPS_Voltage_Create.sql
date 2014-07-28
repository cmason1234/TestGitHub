Use rheem;

CREATE TABLE IF NOT EXISTS rps_voltage(
    voltageId int(11) NOT NULL AUTO_INCREMENT,
	ID int NOT NULL,
	Code nvarchar(2) NULL,
	Power nvarchar(20) NULL,
	PRIMARY KEY (voltageId)
);

