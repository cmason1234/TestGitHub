Use rheem;

CREATE TABLE IF NOT EXISTS ru_certificationgroup(
	CertificationGroupID varchar(64) NOT NULL,
	GroupName varchar(50) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (CertificationGroupID),
	CONSTRAINT UNIQUE INDEX UK_CertificationGroup (GroupName)
);

Call AddColumnIfNotExists(null, 'ru_certification', 'CertificationGroupID',  'varchar(64) NOT NULL');

