Use rheem;

CREATE TABLE IF NOT EXISTS ru_lists(
	ListID varchar(64) NOT NULL,
	ListName varchar(50) NOT NULL,
	ListType varchar(50) NOT NULL,
	Description varchar(512) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ListID)
);

