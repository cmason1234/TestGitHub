Use rheem;

CREATE TABLE IF NOT EXISTS ru_personrole(
	PersonRoleID varchar(64) NOT NULL,
	PersonID varchar(64) NOT NULL,
	ApplicationRoleID varchar(64) NOT NULL,
	DeleteColumn char(10) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (PersonRoleID)
);

call CreateIndexIfNotExists(null, 'personrole_idx1', 'ru_personrole', 'PersonID', null);
call CreateIndexIfNotExists(null, 'personrole_idx2', 'ru_personrole', 'ApplicationRoleID', null);
