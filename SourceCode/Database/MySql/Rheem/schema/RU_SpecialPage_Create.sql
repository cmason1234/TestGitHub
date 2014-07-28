Use rheem;

CREATE TABLE IF NOT EXISTS ru_specialpage(
	SpecialPageID varchar(64) NOT NULL,
	PageTitle varchar(250) NULL,
	CreationDate datetime NULL,
	AuthorPersonID varchar(64) NULL,
	HTMLContent longtext NULL,
	BrandID varchar(64) NULL,
	Disabled bit NULL,
	TopContractor bit NULL,
	Contractor bit NULL,
	PROSTOCK bit NULL,
	CoolZone bit NULL,
	SpecialPage bit NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (SpecialPageID)
);

