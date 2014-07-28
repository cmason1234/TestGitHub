Use rheem;

CREATE TABLE IF NOT EXISTS ru_apiaccessmatrix(
	APIAccessMatrixID varchar(36) NOT NULL,
	APIAccessKeyID varchar(36) NOT NULL,
	APIRouteID varchar(36) NOT NULL,
	Method Varchar(255) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (APIAccessMatrixID)
);

call CreateIndexIfNotExists(NULL, 'apiaccessmatrix_idx1', 'ru_apiaccessmatrix', 'APIAccessKeyID', NULL);
call CreateIndexIfNotExists(NULL, 'apiaccessmatrix_idx2', 'ru_apiaccessmatrix', 'APIRouteID', NULL);

   -- Constraint FK_APIAccessMatrix_APIAccessKey_APIAccessKeyID Foreign Key (APIAccessKeyID) references RU_APIAccessKey(APIAccessKeyID) on delete cascade,
   -- Constraint FK_APIAccessMatrix_APIRoute_APIRouteID Foreign Key (APIRouteID) references RU_APIRoute(APIRouteID) on delete cascade