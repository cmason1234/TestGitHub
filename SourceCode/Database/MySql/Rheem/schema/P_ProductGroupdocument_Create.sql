Use rheem;

CREATE TABLE IF NOT EXISTS p_productgroupdocument(
	ProductGroupDocumentID varchar(64) NOT NULL,
	ProductGroupID varchar(64) NULL,
	DocumentID varchar(64) NULL,
	PairingType varchar(50) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ProductGroupDocumentID)
);

call CreateIndexIfNotExists(NULL, 'ProdGrpDoc_idx1', 'p_productgroupdocument', 'ProductGroupID', NULL);
call CreateIndexIfNotExists(NULL, 'ProdGrpDoc_idx2', 'p_productgroupdocument', 'DocumentID', NULL);

