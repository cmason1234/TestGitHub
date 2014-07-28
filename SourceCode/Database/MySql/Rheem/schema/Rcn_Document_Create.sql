Use rheem;

CREATE TABLE IF NOT EXISTS rcn_document(
	DocumentID varchar(64) NOT NULL,
	DocumentTitle varchar(256) NOT NULL,
	DocumentNumber varchar(256) NULL,
	Category varchar(50) NOT NULL,
	Keywords varchar(2048) NULL,
	Filename varchar(256) NULL,
	MimeTypeOLD varchar(50) NULL,
	Hot bit NULL,
	MimeType varchar(512) NULL,
	PRIMARY KEY (DocumentID)
);
