Use rheem;

CREATE TABLE IF NOT EXISTS ru_rebateprogrammember(
	RebateProgramMemberID varchar(64) NOT NULL,
	RebateProgramID varchar(64) NULL,
	OrganizationID varchar(64) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (RebateProgramMemberID)
);

call CreateIndexIfNotExists(null, 'rebprogmem_idx1', 'ru_rebateprogrammember', 'RebateProgramID', null);
call CreateIndexIfNotExists(null, 'rebprogmem_idx2', 'ru_rebateprogrammember', 'OrganizationID', null);
