Use rheem;

CREATE TABLE IF NOT EXISTS sp_loadmyorgsparents(
	OrganizationID varchar(64) NOT NULL,
    PersonID varchar(64) NOT NULL
);

call CreateIndexIfNotExists(NULL, 'loadmyorgpar_idx1', 'sp_loadmyorgsparents', 'PersonID', NULL);
call CreateIndexIfNotExists(NULL, 'loadmyorgpar_idx2', 'sp_loadmyorgsparents', 'OrganizationID', NULL);
