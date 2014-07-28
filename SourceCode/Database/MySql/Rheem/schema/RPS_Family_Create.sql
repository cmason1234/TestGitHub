Use rheem;

CREATE TABLE IF NOT EXISTS rps_family(
    familyId int(11) NOT NULL AUTO_INCREMENT,
	ID int NULL,
	Manufacturer nvarchar(50) NULL,
	Type nvarchar(5) NULL,
	Family nvarchar(5) NULL,
	Status smallint NULL,
	Description nvarchar(100) NULL,
	ModDigitA nvarchar(1) NULL,
	ModDigitB nvarchar(1) NULL,
	Cap1 int NULL,
	Cap2 int NULL,
	Cap3 int NULL,
	Cap4 int NULL,
	Cap5 int NULL,
	Cap6 int NULL,
	Cap7 int NULL,
	Cap8 int NULL,
	Pwr1 nvarchar(50) NULL,
	Pwr2 nvarchar(50) NULL,
	Pwr3 nvarchar(50) NULL,
	Pwr4 nvarchar(50) NULL,
	Pwr5 nvarchar(50) NULL,
	DirectDrive bit NULL,
	BeltDrive bit NULL,
	PRIMARY KEY (familyId)
);

