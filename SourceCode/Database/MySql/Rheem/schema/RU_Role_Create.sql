Use rheem;

CREATE TABLE IF NOT EXISTS ru_role(
	RoleID varchar(64) NOT NULL,
	RoleName varchar(50) NOT NULL,
	SortOrder int NULL,
	Description varchar(50) NULL,
	DisplayName varchar(50) NULL,
	VaultCode int NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (RoleID)
);

