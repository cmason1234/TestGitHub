Use rheem;

CREATE TABLE IF NOT EXISTS ru_cloudimage(
	CloudImageID varchar(64) NOT NULL, 
	CloudDocumentID varchar(64) NOT NULL, 
	Height int NOT NULL, 
	Width int NOT NULL, 
	MasterImage bit not NULL, 
	Generated bit not NULL,
    PRIMARY KEY (CloudImageID) 
);

call CreateIndexIfNotExists(NULL, 'cloudimage_idx1', 'ru_cloudimage', 'CloudDocumentID', NULL);
