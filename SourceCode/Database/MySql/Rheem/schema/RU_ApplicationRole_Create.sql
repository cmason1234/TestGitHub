Use rheem;

CREATE TABLE IF NOT EXISTS ru_applicationrole(
	ApplicationRoleID varchar(64) NOT NULL,
	ApplicationID varchar(64) NOT NULL,
	RoleID varchar(64) NOT NULL,
	RoleCategoryID varchar(64) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ApplicationRoleID)
);

call CreateIndexIfNotExists(NULL, 'applicationrole_idx1', 'ru_applicationrole', 'ApplicationID', NULL);
call CreateIndexIfNotExists(NULL, 'applicationrole_idx2', 'ru_applicationrole', 'RoleID', NULL);
call CreateIndexIfNotExists(NULL, 'applicationrole_idx3', 'ru_applicationrole', 'RoleCategoryID', NULL);
