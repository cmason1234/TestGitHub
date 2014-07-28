Use econet;

CREATE TABLE IF NOT EXISTS equipmentcategory(
	EquipmentCategoryId INT NOT NULL AUTO_INCREMENT ,
	CategoryName varchar(45) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (EquipmentCategoryId) 
);
/*
Categories are : AC, WH, POOL, OTHER
*/

/*
Don't need this table.. this data will reside at equipmentmaster table
CREATE TABLE IF NOT EXISTS equipmentsubcategory(
	EquipmentSubCategoryId INT NOT NULL AUTO_INCREMENT ,
	EquipmentCategoryId INT NOT NULL,
	SubCategoryName varchar(45) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (EquipmentSubCategoryId),
		CONSTRAINT FK_EquipmentSubCategory_1 FOREIGN KEY (EquipmentCategoryId) REFERENCES equipmentcategory(EquipmentCategoryId) ON DELETE CASCADE 
);
SubCategories are: Thermostat, Water Heater, Pool Heater
*/

/*
SKIP THIS FOR NOW... TBD
CREATE TABLE IF NOT EXISTS equipmentreference(
	EquipmentReferenceId INT NOT NULL AUTO_INCREMENT ,
	EquipmentSubCategoryId INT NOT NULL,
	SubCategoryName varchar(45) NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (EquipmentReferenceId),
		CONSTRAINT FK_EquipmentReference_1 FOREIGN KEY (EquipmentSubCategoryId) REFERENCES equipmentsubcategory(EquipmentSubCategoryId) ON DELETE CASCADE 
);
*/

CREATE TABLE IF NOT EXISTS equipmentmaster(
	EquipmentMasterId INT NOT NULL AUTO_INCREMENT,
	EquipmentCategoryId INT NOT NULL,
	LowerLimit INT NULL,
	UpperLimit INT NULL,
	DisplayInMobile bit NOT null default 0,
	EquipmentDesc  varchar(500) NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (EquipmentMasterId),
		CONSTRAINT FK_EquipmentMaster_1 FOREIGN KEY (EquipmentCategoryId) REFERENCES equipmentcategory(EquipmentCategoryId) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS softwareversion(
	SoftwareVersionId INT NOT NULL AUTO_INCREMENT,
	Version varchar(45) NOT NULL,
	VerisonURL varchar(500) NULL,
	CurrentVersion bit NOT NULL,
	EquipmentMasterId INT NOT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (SoftwareVersionId),	
		CONSTRAINT FK_SoftwareVersion_2 FOREIGN KEY (EquipmentMasterId) REFERENCES equipmentmaster(EquipmentMasterId) ON DELETE CASCADE		
);



CREATE TABLE IF NOT EXISTS equipment(
	EquipmentId INT NOT NULL AUTO_INCREMENT ,
	EquipmentMasterId INT NOT NULL,
	ModelNumber varchar(50) NOT NULL,
	SerialNumber varchar(50) NULL,
	UserLocationMACId INT NULL DEFAULT NULL,
	MACUnpairedId  INT NULL DEFAULT NULL,
	SystemName varchar(50) NOT NULL,
	IsConnected bit NOT NULL,
	Category varchar(50) NOT NULL,
	SubCategory varchar(50) NOT NULL,
	DestinationAddress INT NULL,
	DestinationBus INT NULL,
	CreateDateTime__Gen datetime not NULL,
	UpdateDateTime__Gen datetime not NULL,
    PRIMARY KEY (EquipmentId) 
);

/*call rheem.AddColumnIfNotExists('econet', 'equipment', 'EquipmentSubCategoryId',  'INT NULL');
call rheem.CreateForeignKeyIfNotExists('econet', 'FK_Equipment_2', 'equipment', 'EquipmentSubCategoryId', 'equipmentsubcategory', 'EquipmentSubCategoryId', 'dropAndReplace', 'ON DELETE NO ACTION');		*/
call rheem.CreateForeignKeyIfNotExists('econet', 'FK_Equipment_3', 'equipment', 'UserLocationMACId', 'userlocationmac', 'UserLocationMACId', 'dropAndReplace', 'ON DELETE NO ACTION');		
call rheem.CreateForeignKeyIfNotExists('econet', 'FK_Equipment_4', 'equipment', 'MACUnpairedId', 'macunpaired', 'MACUnpairedId', 'dropAndReplace', 'ON DELETE NO ACTION');		
call rheem.CreateForeignKeyIfNotExists('econet', 'FK_Equipment_5', 'equipment', 'EquipmentMasterId', 'equipmentmaster', 'EquipmentMasterId', 'dropAndReplace', 'ON DELETE NO ACTION');		
/*call rheem.CreateIndexIfNotExists('econet', 'Equipment_idx1', 'equipment', 'UserSystemId', null);*/

 
