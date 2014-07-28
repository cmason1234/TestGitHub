Use rheem;

CREATE TABLE IF NOT EXISTS ru_department(
	DepartmentID varchar(64) NOT NULL,
	SequenceNumber int NULL,
	DepartmentName varchar(50) NOT NULL,
	LegacyCode int NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	PRIMARY KEY (DepartmentID)
);

