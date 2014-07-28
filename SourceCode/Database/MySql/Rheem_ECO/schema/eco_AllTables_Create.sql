CREATE SCHEMA IF NOT EXISTS rheem_eco;
Use rheem_eco;

-- //EcoNET tables
-- // FOR NOW -- Leave off the calls to CreateIndexIfNotExists because it does not work across schemas...we'll add them back later.

-- //product==================================================================
CREATE TABLE IF NOT EXISTS product (
    ProductID INT NOT NULL AUTO_INCREMENT ,
    ProductDesc VARCHAR(50) NULL ,
    AddressLower INT NULL ,
    AddressUpper INT NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (ProductID) )
COMMENT = 'Stores the 3 digit address of a product. SS:704-767, HPWH:320-383';

-- //call CreateIndexIfNotExists(NULL, 'product_idxProductID', 'product', 'ProductID', NULL);
-- //call CreateIndexIfNotExists(NULL, 'product_idxlower', 'product', 'AddressLower', NULL);
-- //call CreateIndexIfNotExists(NULL, 'product_idxupper', 'product', 'AddressUpper', NULL);

-- //mode=====================================================================
CREATE TABLE IF NOT EXISTS productmode (
    ProductModeID INT NOT NULL AUTO_INCREMENT ,
    ProductID INT NULL,
    Mode INT NULL ,
    ModeShortDesc VARCHAR(50) NULL ,
    ModeLongDesc VARCHAR(5000) NULL ,
    TempMin INT NULL ,
    TempMax INT NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (ProductModeID),
		CONSTRAINT FK_ProductMode_1 FOREIGN KEY (ProductID)
		  REFERENCES product(ProductID) ON DELETE CASCADE )
COMMENT = 'This is a lookup table that stores the modes that are specific to a product.  tempmin/tempmax = 85-130 F for Energy Saver, or 85-140 F for all other modes';

-- //call CreateIndexIfNotExists(NULL, 'mode_idxProductID', 'productmode', 'ProductID', NULL);
-- //call CreateIndexIfNotExists(NULL, 'mode_idxmode', 'productmode', 'ProductModeID', NULL);

-- //productstatus===================================================================
CREATE TABLE IF NOT EXISTS productstatus (
    ProductStatusID INT NOT NULL AUTO_INCREMENT ,
    ProductID INT NULL,
    ProductStatus INT NULL ,
    ProductStatusShortDesc VARCHAR(50) NULL ,
    ProductStatusLongDesc VARCHAR(5000) NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (ProductStatusID),
		CONSTRAINT FK_ProductStatus_1 FOREIGN KEY (ProductID)
		  REFERENCES product(ProductID) ON DELETE CASCADE )
COMMENT = 'This is a lookup table that stores the productstatus that are specific to a product.';

-- //call CreateIndexIfNotExists(NULL, 'productstatus_idxProductID', 'productstatus', 'ProductID', NULL);
-- //call CreateIndexIfNotExists(NULL, 'productstatus_idxproductstatus', 'productstatus', 'productstatus', NULL);

-- //Alarm====================================================================
CREATE TABLE IF NOT EXISTS productalarm (
    ProductAlarmID INT NOT NULL AUTO_INCREMENT ,
    ProductID INT NULL,
    AlarmName VARCHAR(50) NULL ,
    AlarmType INT NULL,
    AlarmShortDesc VARCHAR(50) NULL ,
    AlarmLongDesc VARCHAR(5000) NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (ProductAlarmID),
		CONSTRAINT FK_ProductAlarm_1 FOREIGN KEY (ProductID)
		  REFERENCES product(ProductID) ON DELETE CASCADE )
COMMENT = 'This is a lookup table that stores the Alarms that are specific to a product.  Alarmtype (0=message, 1=critical)';

-- //call CreateIndexIfNotExists(NULL, 'Alarm_idxProductID', 'alarm', 'ProductID', NULL);
-- //call CreateIndexIfNotExists(NULL, 'Alarm_idxAlarm', 'alarm', 'Alarm', NULL);

-- //product_owner====================================================================
CREATE TABLE IF NOT EXISTS homeowner (
    HomeOwnerID INT NOT NULL AUTO_INCREMENT ,
    FirstName VARCHAR(50) NULL ,
    LastName VARCHAR(50) NULL ,
    Email VARCHAR(50) NULL ,
    Password VARCHAR(50) NULL ,
    PasswordSeed VARCHAR(50) NULL ,
    PasswordDate DATETIME NULL ,
    Phone VARCHAR(50) NULL ,
    PhoneAlt VARCHAR(50) NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (HomeOwnerID) )
COMMENT = 'Stores the Owner/Consumer data.';

-- //owneraddress=============================================================
CREATE TABLE IF NOT EXISTS homeowneraddress (
    HomeOwnerAddressID INT NOT NULL AUTO_INCREMENT ,
    HomeOwnerID INT NULL ,
    AddressType VARCHAR(50) NULL ,
    Address1 VARCHAR(100) NULL ,
    Address2 VARCHAR(100) NULL ,
    City VARCHAR(100) NULL ,
    State VARCHAR(3) NULL ,
    PostalCode VARCHAR(50) NULL ,
    Country VARCHAR(50) NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (HomeOwnerAddressID),
		CONSTRAINT FK_HomeOwnerAddress_1 FOREIGN KEY (HomeOwnerID)
		  REFERENCES homeowner(HomeOwnerID) ON DELETE CASCADE )
COMMENT = 'These are the addresses that belong to an Owner';

-- //call CreateIndexIfNotExists(NULL, 'homeowneraddress_idxhomeownerid', 'homeowneraddress', 'HomeOwnerID', NULL);

-- //ownerorder=============================================================
CREATE TABLE IF NOT EXISTS homeownerorder (
    HomeOwnerOrderID INT NOT NULL AUTO_INCREMENT ,
    HomeOwnerID INT NULL ,
    OrderDate DATETIME NULL ,
    OrderStatus VARCHAR(50) NULL ,
    OrderTrackingNum VARCHAR(50) NULL ,
    OrderNote VARCHAR(1500) NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (HomeOwnerOrderID),
		CONSTRAINT FK_HomeOwnerOrder_1 FOREIGN KEY (HomeOwnerID)
		  REFERENCES homeowner(HomeOwnerID) ON DELETE CASCADE )
COMMENT = 'This is the Order data.  Owners who order IMP/WiFi module will have records here.';

-- //call CreateIndexIfNotExists(NULL, 'homeownerorder_idxhomeownerid', 'homeownerorder', 'HomeOwnerID', NULL);

-- //ownerorderhistory======================================================
CREATE TABLE IF NOT EXISTS homeownerorderhistory (
    HomeOwnerOrderHistoryID INT NOT NULL AUTO_INCREMENT ,
    HomeOwnerOrderID INT NULL ,
    OrderStatus VARCHAR(50) NULL ,
    OrderNote VARCHAR(1500) NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (HomeOwnerOrderHistoryID),
		CONSTRAINT FK_HomeOwnerOrderHistory_1 FOREIGN KEY (HomeOwnerOrderID)
		  REFERENCES homeownerorder(HomeOwnerOrderID) ON DELETE CASCADE )
COMMENT = 'History of owner orders';

-- //call CreateIndexIfNotExists(NULL, 'homeownerorderhistory_idxhomeownerorderid', 'homeownerorderhistory', 'HomeOwnerOrderID', NULL);

-- //ownersystem============================================================
CREATE TABLE IF NOT EXISTS homeownersystem (
    HomeOwnerSystemID INT NOT NULL AUTO_INCREMENT ,
    HomeOwnerID INT NULL ,
    HomeOwnerAddressID INT NULL ,
    SystemName VARCHAR(50) NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (HomeOwnerSystemID),
		CONSTRAINT FK_HomeOwnerSystem_1 FOREIGN KEY (HomeOwnerID)
		  REFERENCES homeowner(HomeOwnerID) ON DELETE CASCADE,
		CONSTRAINT FK_HomeOwnerSystem_2 FOREIGN KEY (HomeOwnerAddressID)
		  REFERENCES homeowneraddress(HomeOwnerAddressID) ON DELETE CASCADE )
COMMENT = 'This tables provides scalability - Owner can create a system which will hold multiple equipments.';

-- //call CreateIndexIfNotExists(NULL, 'homeownersystem_idxhomeownerid', 'homeownersystem', 'HomeOwnerID', NULL);

-- //equipment=====================================================================
CREATE TABLE IF NOT EXISTS equipment (
    EquipmentID INT NOT NULL AUTO_INCREMENT ,
    ProductID INT NULL ,
    ModelNumber VARCHAR(50) NULL ,
    SerialNumber VARCHAR(50) NULL ,
    RegisterDate DATETIME NULL ,
    InstallDate DATETIME NULL ,
    InstallPro INT ,
    InstallType VARCHAR(50) NULL ,
    InstallLocation VARCHAR(50) NULL ,
    EquipmentName VARCHAR(50) NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (EquipmentID),
		CONSTRAINT FK_Equipment_1 FOREIGN KEY (ProductID)
		  REFERENCES product(ProductID) ON DELETE CASCADE )
COMMENT = 'This has data specific to a equipment or piece of equipment.';

-- //call CreateIndexIfNotExists(NULL, 'equipment_idxproductid', 'equipment', 'ProductID', NULL);

-- //homeownersystemequipment==========================================================
-- CREATE TABLE IF NOT EXISTS homeownersystemequipment (
--     HomeOwnerSystemEquipmentID INT NOT NULL AUTO_INCREMENT ,
--     HomeOwnerSystemID INT NULL ,
--     EquipmentID INT NULL ,	
--     CreateDateTime__Gen DATETIME NULL,
--     UpdateDateTime__Gen DATETIME NULL,
-- 		PRIMARY KEY (HomeOwnerSystemEquipmentID),
-- 		CONSTRAINT FK_HomeEquipmentOwnerSystem_1 FOREIGN KEY (HomeOwnerSystemID)
-- 		  REFERENCES homeownersystem(HomeOwnerSystemID) ON DELETE CASCADE,
-- 		CONSTRAINT FK_EquipmentOwnerSystem_2 FOREIGN KEY (EquipmentID)
-- 		  REFERENCES equipment(EquipmentID) ON DELETE CASCADE )
-- COMMENT = 'These are the equipments that belong to a system.';

-- //call CreateIndexIfNotExists(NULL, 'homeownersystemequipment_idxhomeownersystemid', 'homeownersystemequipment', 'HomeOwnerSystemID', NULL);
-- //call CreateIndexIfNotExists(NULL, 'homeownersystemequipment_idxequipmentid', 'homeownersystemequipment', 'EquipmentID', NULL);

-- //whequipmentsetting============================================================
CREATE TABLE IF NOT EXISTS whequipmentsetting (
    WhEquipmentSettingID INT NOT NULL AUTO_INCREMENT ,
    HomeOwnerSystemID INT NULL ,
    EquipmentID INT NULL ,
    ProductModeID INT DEFAULT NULL,
    ProductStatusID INT DEFAULT NULL,  
    HttpAgent varchar(25) DEFAULT NULL,
    Temperature float DEFAULT NULL,
    SetPoint float DEFAULT NULL,
    WhEquipmentSettingSource varchar(45) DEFAULT NULL,
    Alarm INT DEFAULT NULL,
    Alarm_01 varchar(4) DEFAULT NULL,
    Alarm_02 varchar(4) DEFAULT NULL,
    Alarm_03 varchar(4) DEFAULT NULL,
	EquipmentAddress INT NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (WhEquipmentSettingID),
		CONSTRAINT FK_WhEquipmentSetting_1 FOREIGN KEY (HomeOwnerSystemID)
		  REFERENCES homeownersystem(HomeOwnerSystemID) ON DELETE CASCADE,
		CONSTRAINT FK_WhEquipmentSetting_2 FOREIGN KEY (EquipmentID)
		  REFERENCES equipment(EquipmentID) ON DELETE CASCADE,
		CONSTRAINT FK_WhEquipmentSetting_3 FOREIGN KEY (ProductModeID)
		  REFERENCES productmode(ProductModeID) ON DELETE CASCADE,
		CONSTRAINT FK_WhEquipmentSetting_4 FOREIGN KEY (ProductStatusID)
		  REFERENCES productstatus(ProductStatusID) ON DELETE CASCADE )
COMMENT = 'These are the settings of the water heater';

-- //call CreateIndexIfNotExists(NULL, 'whequipmentsetting_idxhttpagent', 'whequipmentsetting', 'HttpAgent', NULL);

-- //whequipmentsettinghistory=====================================================
CREATE TABLE IF NOT EXISTS whequipmentsettinghistory (
    WhEquipmentSettingHistoryID INT NOT NULL AUTO_INCREMENT ,
    WhEquipmentSettingID INT NOT NULL ,
    ProductStatusID INT DEFAULT NULL,  
    ProductModeID INT DEFAULT NULL,
    Temperature float DEFAULT NULL,
    SetPoint float DEFAULT NULL,
    WhEquipmentSettingSource varchar(45) DEFAULT NULL,
    Alarm INT DEFAULT NULL,
    Alarm_01 varchar(4) DEFAULT NULL,
    Alarm_02 varchar(4) DEFAULT NULL,
    Alarm_03 varchar(4) DEFAULT NULL,
	EquipmentAddress INT NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (WhEquipmentSettingHistoryID),
		CONSTRAINT FK_WhEquipmentSettingHistory_1 FOREIGN KEY (WhEquipmentSettingID)
		  REFERENCES whequipmentsetting(WhEquipmentSettingID) ON DELETE CASCADE,
		CONSTRAINT FK_WhEquipmentSettingHistory_2 FOREIGN KEY (ProductStatusID)
		  REFERENCES productstatus(ProductStatusID) ON DELETE CASCADE,
		CONSTRAINT FK_WhEquipmentSettingHistory_3 FOREIGN KEY (ProductModeID)
		  REFERENCES productmode(ProductModeID) ON DELETE CASCADE)
COMMENT = 'This is the history of a water heater.';

-- //homeownertoken==================================================================
CREATE TABLE IF NOT EXISTS homeownertoken (
    HomeOwnerTokenID INT NOT NULL AUTO_INCREMENT ,
    HomeOwnerID INT NOT NULL,
    DeviceToken VARCHAR(50) NOT NULL ,
    CreateDateTime__Gen DATETIME NULL,
    UpdateDateTime__Gen DATETIME NULL,
		PRIMARY KEY (HomeOwnerTokenID),
		CONSTRAINT FK_HomeOwnerToken_1 FOREIGN KEY (HomeOwnerID)
		  REFERENCES homeowner(HomeOwnerID) ON DELETE CASCADE )
COMMENT = 'This is a table to hold the device token and it tied to the home owner with a foreign key';
