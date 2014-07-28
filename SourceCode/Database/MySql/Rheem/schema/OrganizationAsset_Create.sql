Use rheem;

CREATE TABLE IF NOT EXISTS organizationasset(
    OrganizationAssetID int(11) NOT NULL AUTO_INCREMENT,
    OrganizationID varchar(64) NOT NULL,
	AssetName varchar(50) NOT NULL,
	AssetType varchar(50) NOT NULL,
    AssetCategory varchar(250) NOT NULL,
    AssetURL varchar(250) NOT NULL,
	Disabled bit NOT NULL DEFAULT 0,
    CreateDateTime__Gen datetime NULL,
    UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (OrganizationAssetID) 
);

call CreateIndexIfNotExists(NULL, 'organizationasset_idx1', 'organizationasset', 'OrganizationID', NULL);