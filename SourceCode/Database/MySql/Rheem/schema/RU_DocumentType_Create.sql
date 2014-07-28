Use rheem;

CREATE TABLE IF NOT EXISTS ru_documenttype(
	DocumentTypeID varchar(64) NOT NULL,
	TypeName varchar(100) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (DocumentTypeID),
    CONSTRAINT UK_DocumentType UNIQUE INDEX (TypeName)
);
