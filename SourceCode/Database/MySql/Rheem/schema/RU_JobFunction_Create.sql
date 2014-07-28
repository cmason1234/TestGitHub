Use rheem;

CREATE TABLE IF NOT EXISTS ru_jobfunction(
	JobFunctionID varchar(64) NOT NULL,
	Description varchar(50) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	PRIMARY KEY (JobFunctionID)
);

