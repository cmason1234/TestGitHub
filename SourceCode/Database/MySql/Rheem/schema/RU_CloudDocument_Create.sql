Use rheem;

CREATE TABLE IF NOT EXISTS ru_clouddocument(
	CloudDocumentID varchar(64) NOT NULL,
	ObjectID varchar(64) NOT NULL,
	ObjectType varchar(50) NOT NULL,
	DocumentTitle varchar(256) NULL,
	DocumentNumber int NOT NULL,
	ObjectDocumentNumber int NOT NULL,
	FriendlyName varchar(256) NULL,
	Abstract text NULL,
	Disabled bit NOT NULL,
	UploadedFileName varchar(200) NOT NULL,
	CloudFileName varchar(200) NOT NULL,
	CloudBucket varchar(50) NOT NULL,
	IsImage bit NOT NULL,
	FileExtension varchar(5) NOT NULL,
	DocumentTypeID varchar(64) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (CloudDocumentID)
	#,FOREIGN KEY FK_CloudDocument_DocumentTypeID (DocumentTypeID)
	#    REFERENCES RU_DocumentType (DocumentTypeID) ON DELETE CASCADE
);


call CreateIndexIfNotExists(NULL, 'clouddoc_idx1', 'ru_clouddocument', 'ObjectID', NULL);
call CreateIndexIfNotExists(NULL, 'clouddoc_idx2', 'ru_clouddocument', 'DocumentTypeID', NULL);

