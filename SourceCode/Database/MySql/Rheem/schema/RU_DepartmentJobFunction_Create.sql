Use rheem;

CREATE TABLE IF NOT EXISTS ru_departmentjobfunction(
	DepartmentJobFunctionID varchar(64) NOT NULL,
	DepartmentID varchar(64) NOT NULL,
	JobFunctionID varchar(64) NOT NULL,
	LegacyCode int NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	PRIMARY KEY (DepartmentJobFunctionID)
);

call CreateIndexIfNotExists(null, 'deptjobfunc_idx1', 'ru_departmentjobfunction', 'DepartmentID', null);
call CreateIndexIfNotExists(null, 'deptjobfunc_idx2', 'ru_departmentjobfunction', 'JobFunctionID', null);
