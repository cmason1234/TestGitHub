Use rheem;

CREATE TABLE IF NOT EXISTS ru_persondepartmentjob(
	PersonDepartmentJobID varchar(64) NOT NULL,
	PersonID varchar(64) NOT NULL,
	DepartmentJobFunctionID varchar(64) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	PRIMARY KEY (PersonDepartmentJobID)
);

call CreateIndexIfNotExists(null, 'persondeptjob_idx1', 'ru_persondepartmentjob', 'PersonID', null);
call CreateIndexIfNotExists(null, 'persondeptjob_idx2', 'ru_persondepartmentjob', 'DepartmentJobFunctionID', null);
