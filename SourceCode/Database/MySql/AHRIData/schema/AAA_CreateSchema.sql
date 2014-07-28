CREATE SCHEMA IF NOT EXISTS ahridata;
Use ahridata;

CREATE TABLE IF NOT EXISTS ahriwhdata (
    ahriwhdataID INT NOT NULL AUTO_INCREMENT ,
	AHRIReferenceNumber varchar(200) NOT NULL,
	OEMTradeName Varchar(256) NOT NULL,	
	IsActive bit NOT NULL default 0,
	ModelNumber Varchar(256) NOT NULL,
	EnergySource Varchar(256) NOT NULL,
	PropaneGas bit Not NULL DEFAULT 0,
	NaturalGas bit Not NULL DEFAULT 0,
	HeatPumpWithTank bit Not NULL DEFAULT 0,
	ElectricResistance bit Not NULL DEFAULT 0,
	ElectricResistanceTableTop bit Not NULL DEFAULT 0,
	HeaterType	varchar(256) NOT NULL,
	EnergyFactor Decimal(6,3) NOT NULL,
	Volume Integer NOT NULL,
	InputVal  Decimal(7,1) NOT NULL,
	RecoveryEff	Integer NOT NULL,
	FirstHourRating	DECIMAL(7,2) NOT NULL,
	TaxCredit bit NOT NULL DEFAULT 0,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
	PRIMARY KEY (ahriwhdataID) 
);

		
Create TABLE IF NOT EXISTS ahriacdata(
    ahriacdataID INT NOT NULL AUTO_INCREMENT ,
	AHRIReferenceNumber varchar(200) NOT NULL,
	IsActive bit NOT NULL default 0,
	ManufacturerType varchar(256),
	OEMTradeName Varchar(256) NOT NULL,
	OutdoorUnitManufacturer varchar(256),
	OutdoorUnitModel varchar(256),
	IndoorUnitManufacturer varchar(256),
	IndoorUnitModel varchar(256),
	FurnaceModel varchar(256),
	CoolingCapacity INTEGER,
	CoolingEER Decimal(6,3),
	CoolingSEER Decimal(6,3),
	Phase INTEGER,
	ARIType varchar(256),
	HSVTC bit not null default 0,
	ExclusivelyforExport bit not null default 0,
	AnnualOperatingCoolingCost INTEGER,
	FedTaxCredit bit not null default 0,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
	PRIMARY KEY (ahriacdataID) 
);

call rheem.CreateIndexIfNotExists('ahridata', 'ahriacdata_idx1', 'ahriacdata', 'AHRIReferenceNumber', null);

Create TABLE IF NOT EXISTS ahriacoemnames(
    ahriacoemnamesID INT NOT NULL AUTO_INCREMENT ,
	AHRIReferenceNumber varchar(256) NOT NULL,
	OEMTradeName Varchar(200) NOT NULL,
	PRIMARY KEY (ahriacoemnamesID),
    INDEX (OEMTradeName asc)
);

ALTER TABLE ahriacoemnames CHANGE COLUMN AHRIReferenceNumber AHRIReferenceNumber VARCHAR(200) NOT NULL  ;

call rheem.CreateIndexIfNotExists('ahridata', 'ahriacoemnames_idx1', 'ahriacoemnames', 'AHRIReferenceNumber', null);

Create TABLE IF NOT EXISTS ahrihpdata(
    ahrihpdataID INT NOT NULL AUTO_INCREMENT ,
	AHRIReferenceNumber varchar(200) NOT NULL,
	IsActive bit NOT NULL default 0,
	ManufacturerType varchar(256),
	OEMTradeName Varchar(256) NOT NULL,
	OutdoorUnitManufacturer varchar(256),
	OutdoorUnitModel varchar(256),
	IndoorUnitManufacturer varchar(256),
	IndoorUnitModel varchar(256),
	FurnaceModel varchar(256),
	CoolingCapacity INTEGER,
	CoolingEER Decimal(6,3),
	CoolingSEER Decimal(6,3),
	HighHeatingCapacity INTEGER,
	HighHeatingHSPF Decimal(8,4),
	LowHeatingCapacity  INTEGER,
	Phase INTEGER,
	ARIType varchar(256),
	HSVTC bit not null default 0,
	ExclusivelyforExport bit not null default 0,
	AnnualOperatingCoolingCost INTEGER,
	AnnualOperatingHeatingCost INTEGER,
	FedTaxCredit bit not null default 0,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
	PRIMARY KEY (ahrihpdataID) 
);

Create TABLE IF NOT EXISTS ahrihpoemnames(
    ahrihpoemnamesID INT NOT NULL AUTO_INCREMENT ,
	AHRIReferenceNumber varchar(256) NOT NULL,
	OEMTradeName Varchar(200) NOT NULL,
	PRIMARY KEY (ahrihpoemnamesID),
    INDEX (OEMTradeName asc)
);


call rheem.CreateIndexIfNotExists('ahridata', 'ahrihpdata_idx1', 'ahrihpdata', 'AHRIReferenceNumber', null);

ALTER TABLE ahrihpoemnames CHANGE COLUMN AHRIReferenceNumber AHRIReferenceNumber VARCHAR(200) NOT NULL  ;

call rheem.CreateIndexIfNotExists('ahridata', 'ahrihpoemnames_idx1', 'ahrihpoemnames', 'AHRIReferenceNumber', null);

Create TABLE IF NOT EXISTS ahrirfrdata(
    ahrirfrdataID INT NOT NULL AUTO_INCREMENT ,
	AHRIReferenceNumber varchar(200) NOT NULL,
	IsActive bit NOT NULL default 0,
	OEMTradeName Varchar(256) NOT NULL,
	Manufacturer varchar(256),
	Model varchar(256),
	ManufacturedHousing varchar(256),
	FuelType varchar(256),
    FuelOil bit not null default 0,
    FuelNaturalGas bit not null default 0,
    FuelPropaneGas bit not null default 0,
	Configuration varchar(256),
    UpFlow bit not null default 0,
    DownFlow bit not null default 0,
    Horizontal bit not null default 0,
	FurnaceType Varchar(256),
	Weatherized bit not null default 0,
	NonWeatherized bit not null default 0,
	InputRating Integer,
	OutputHeatingCapacity Integer,
	AFUE Decimal(6,2),
	Ef Decimal(6, 2),
	Eae  INTEGER,
	PE INTEGER,
	BasicModel bit not null default 0,
	AFUEEligible bit not null default 0,
	AMACF bit not null default 0,
	DateEntered Date NOT NULL,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
	PRIMARY KEY (ahrirfrdataID) 
);

Create TABLE IF NOT EXISTS ahrirfroemnames(
    ahrirfroemnamesID INT NOT NULL AUTO_INCREMENT ,
	AHRIReferenceNumber varchar(256) NOT NULL,
	OEMTradeName Varchar(200) NOT NULL,
	PRIMARY KEY (ahrirfroemnamesID),
    INDEX (OEMTradeName asc)
);
call rheem.CreateIndexIfNotExists('ahridata', 'ahrirfrdata_idx1', 'ahrirfrdata', 'AHRIReferenceNumber', null);

ALTER TABLE ahrirfroemnames CHANGE COLUMN AHRIReferenceNumber AHRIReferenceNumber VARCHAR(200) NOT NULL  ;

call rheem.CreateIndexIfNotExists('ahridata', 'ahrirfroemnames_idx1', 'ahrirfroemnames', 'AHRIReferenceNumber', null);

Create TABLE IF NOT EXISTS ahricounts(
    ahrircountsID INT NOT NULL AUTO_INCREMENT,
	ahriType varchar(20) Not NULL,
	columnCounted varchar(200) NOT NULL,
	columnValue Varchar(200) NOT NULL,
	columnCount integer NOT NULL,
	PRIMARY KEY (ahrircountsID),
    INDEX (ahriType asc),
	INDEX (columnCounted asc)
);

call rheem.AddColumnIfNotExists('ahridata', 'ahricounts', 'SortOrder',  'Int Null Default 0');


Create Table if not exists ahriresultsorder(
	ahriresultsorderID INT NOT NULL AUTO_INCREMENT,
	ahriType varchar(20) Not NULL,
	columnCounted varchar(200) NOT NULL,
	sortOrder int not null default 0,
	PRIMARY KEY (ahriresultsorderID)
);

INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=1, ahriType='AC', columnCounted='OEMTradeName', sortOrder='1';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=2, ahriType='AC', columnCounted='IsActive', sortOrder='2';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=3, ahriType='AC', columnCounted='ManufacturerType', sortOrder='3';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=4, ahriType='AC', columnCounted='OutdoorUnitManufacturer', sortOrder='4';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=5, ahriType='AC', columnCounted='IndoorUnitManufacturer', sortOrder='5';

INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=6, ahriType='HP', columnCounted='OEMTradeName', sortOrder='1';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=7, ahriType='HP', columnCounted='IsActive', sortOrder='2';

INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=8, ahriType='RFR', columnCounted='OEMTradeName', sortOrder='1';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=9, ahriType='RFR', columnCounted='IsActive', sortOrder='2';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=10, ahriType='RFR', columnCounted='FuelType', sortOrder='3';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=11, ahriType='RFR', columnCounted='Configuration', sortOrder='4';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=12, ahriType='RFR', columnCounted='Manufacturer', sortOrder='5';

INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=13, ahriType='WH', columnCounted='OEMTradeName', sortOrder='1';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=14, ahriType='WH', columnCounted='IsActive', sortOrder='2';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=15, ahriType='WH', columnCounted='EnergySource', sortOrder='3';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=16, ahriType='WH', columnCounted='TaxCredit', sortOrder='4';
INSERT IGNORE INTO ahriresultsorder set ahriresultsorderID=17, ahriType='WH', columnCounted='HeaterType', sortOrder='5';

