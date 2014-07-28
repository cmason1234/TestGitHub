Use rheem;

CREATE TABLE IF NOT EXISTS ru_rheemwebsite(
	RheemWebSiteID varchar(64) NOT NULL,
	WebSiteName varchar(50) NOT NULL,
	WebSiteURL varchar(50) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (RheemWebSiteID)
);
