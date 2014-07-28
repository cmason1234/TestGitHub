Use rheem;

CREATE TABLE IF NOT EXISTS sp_loadmyorgs(
	OrganizationID varchar(64) NOT NULL,
    PersonID varchar(64) NOT NULL
);

call CreateIndexIfNotExists(NULL, 'loadmyorg_idx1', 'sp_loadmyorgs', 'PersonID', NULL);
call CreateIndexIfNotExists(NULL, 'loadmyorg_idx2', 'sp_loadmyorgs', 'OrganizationID', NULL);
