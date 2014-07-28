Use rheem;

CREATE TABLE IF NOT EXISTS ru_rebateprogram(
	RebateProgramID varchar(64) NOT NULL,
	ProgramName varchar(50) NULL,
	Description varchar(512) NULL,
	ProgramYear int NULL,
	ListID varchar(64) NULL,
	HTMLTemplateID varchar(64) NULL,
	NumberPrefix varchar(50) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	Disabled bit NOT NULL,
	ApplicationRoleID varchar(64) NULL,
    PRIMARY KEY (RebateProgramID)
);

