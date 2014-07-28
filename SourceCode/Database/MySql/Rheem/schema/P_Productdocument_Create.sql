Use rheem;

CREATE TABLE IF NOT EXISTS p_productdocument(
	ProductDocumentID varchar(64) NOT NULL,
	ProductID varchar(64) NULL,
	DocumentID varchar(64) NULL,
	PairingType varchar(100) NULL,
	MimeType varchar(50) NULL,
	DocumentTitle varchar(256) NULL,
	PublicationDate datetime NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ProductDocumentID)
	#,FOREIGN KEY FK_ProductDocument_ProductID (ProductID)
	#    REFERENCES RU_Product(ProductID) ON DELETE CASCADE
);

call CreateIndexIfNotExists(NULL, 'ProdDoc_idx1', 'p_productdocument', 'ProductID', NULL);
call CreateIndexIfNotExists(NULL, 'ProdDoc_idx2', 'p_productdocument', 'DocumentID', NULL);
