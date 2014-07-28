Use rheem;

CREATE TABLE IF NOT EXISTS ru_apiroute(
	APIRouteID varchar(36) NOT NULL,
	APIMasterID varchar(36) NOT NULL,
	RoutePath varchar(1500) NOT NULL,
	HttpMethod varchar(50) NOT NULL,
	DefaultAccess bit NOT NULL,
	ActionName varchar(200) NOT NULL,
	CreateDateTime__Gen datetime  NULL,
	UpdateDateTime__Gen datetime  NULL,
    PRIMARY KEY (APIRouteID)
	-- Constraint FK_APIRoute_APIMaster_APIMasterID Foreign Key (APIMasterID) references RU_APIMaster(APIMasterID) on delete cascade
);

call CreateIndexIfNotExists(NULL, 'apiroute_idx1', 'ru_apiroute', 'APIMasterID', NULL);
