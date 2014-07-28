Use rheem;

CREATE TABLE IF NOT EXISTS ru_menu(
	MenuID varchar(64) NOT NULL,
	MenuType varchar(50) NULL,
	Label varchar(250) NULL,
	URL varchar(550) NULL,
	Target varchar(50) NULL,
	MenuOrder int NULL,
	ParentID varchar(64) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (MenuID)
);