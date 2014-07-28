Use rheem;

CREATE TABLE IF NOT EXISTS ru_listuserlist(
	ListUserListID varchar(64) NOT NULL,
	ListID varchar(64) NOT NULL,
	PersonID varchar(64) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ListUserListID)
);


