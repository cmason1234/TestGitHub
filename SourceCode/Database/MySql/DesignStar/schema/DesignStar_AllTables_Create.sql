CREATE SCHEMA IF NOT EXISTS designstar;
Use designstar;

CREATE TABLE IF NOT EXISTS designstarparent (
    DesignStarParentID INT NOT NULL AUTO_INCREMENT ,
    SoftwareProgramUsed VARCHAR(100) NULL ,
	XMLType varchar(100) NULL ,
	XMLGeneratedBy varchar(100) NULL ,
	TransactionType varchar(100) NULL ,
	CreatedDateAndTime DATETIME NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (DesignStarParentID) );

CREATE TABLE IF NOT EXISTS project (
    ProjectID INT NOT NULL AUTO_INCREMENT ,
	DesignStarParentID INT NOT NULL ,
	HPXML_BuildingID varchar(100) NOT NULL ,
	HPXML_ProjectID varchar(100) NOT NULL ,
	ProjectSystemIdentifiers varchar(100) NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (ProjectID) );

CREATE TABLE IF NOT EXISTS customer (
    CustomerID INT NOT NULL AUTO_INCREMENT ,
	DesignStarParentID INT NOT NULL ,
    PersonID INT NOT NULL ,
	SystemIdentifier varchar(100) NOT NULL ,
    MailingAddressID INT NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (CustomerID) );

call rheem.CreateIndexIfNotExists('designstar', 'Customer_idxPersonID', 'customer',  'PersonID', 'leaveUnchanged');
call rheem.CreateIndexIfNotExists('designstar', 'Customer_idxMailingAddressID', 'customer',  'MailingAddressID', 'leaveUnchanged');
call rheem.CreateIndexIfNotExists('designstar', 'Customer_idxSystemIdentifier', 'customer',  'SystemIdentifier', 'leaveUnchanged');

CREATE TABLE IF NOT EXISTS person (
    PersonID INT NOT NULL AUTO_INCREMENT ,
    FirstName varchar(100) NOT NULL ,
    LastName varchar(100) NOT NULL ,
    EmailAddress varchar(254) NULL ,
	IndividualType varchar(100) NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (PersonID) );

CREATE TABLE IF NOT EXISTS telephone (
    TelephoneID INT NOT NULL AUTO_INCREMENT ,
	PersonID INT NOT NULL ,
    TelephoneType varchar(100) NOT NULL ,
    TelephoneNumber varchar(100) NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (TelephoneID) );

CREATE TABLE IF NOT EXISTS phoneperson (
    PhonePersonID INT NOT NULL AUTO_INCREMENT ,
    PersonID INT NOT NULL ,
    PhoneType varchar(100) NULL ,
    PhoneNumber varchar(100) NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (PhonePersonID) );

CREATE TABLE IF NOT EXISTS mailingaddress (
    MailingAddressID INT NOT NULL AUTO_INCREMENT ,
    AddressLine1 varchar(100) NOT NULL ,
    AddressLine2 varchar(100) NULL ,
    City varchar(100) NOT NULL ,
    State varchar(3) NOT NULL ,
	PostalCode varchar(100) NOT NULL ,
    Country varchar(50) NOT NULL ,
    AddressType varchar(50) NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (MailingAddressID) );

CREATE TABLE IF NOT EXISTS building (
    BuildingID INT NOT NULL AUTO_INCREMENT ,
    DesignStarParentID INT NOT NULL ,
	ClimateAndRiskZoneID INT NULL ,
	AirInfiltrationMeasurementID INT NULL ,
	ConsumptionInfoBuildingID INT NULL ,
	HPXML_BuildingID varchar(100) NOT NULL ,
	HPXML_CustomerID varchar(100) NOT NULL ,
	ProjectStatusEventType varchar(100) NOT NULL ,
	ProjectStatusDate DATETIME NOT NULL ,
    YearBuilt INT NULL ,
    ResidentialFacilityType varchar(100) NULL ,
    AverageCeilingHeight FLOAT NULL ,
	ConditionedFloorArea FLOAT NULL ,
	NumberofStoriesAboveGrade INT NULL ,
    BuildingVolume FLOAT NULL ,
    AverageAtticRValue FLOAT NULL ,
    AverageWallRValue FLOAT NULL ,
    AverageFloorRValue FLOAT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (BuildingID) );

CREATE TABLE IF NOT EXISTS attic (
    AtticID INT NOT NULL AUTO_INCREMENT ,
	SystemIdentifier varchar(100) NOT NULL ,
    BuildingID INT NOT NULL ,
	InsulationID INT NULL ,
    Area FLOAT NULL ,
	RafterSize varchar(100) NULL ,
	RafterSpacing float NULL ,
	RafterFramingFactor float NULL ,
	RafterMaterial varchar(100) NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (AtticID) );

call rheem.CreateIndexIfNotExists('designstar', 'Attic_idxSystemIdentifier', 'attic',  'SystemIdentifier', 'leaveUnchanged');

CREATE TABLE IF NOT EXISTS wall (
    WallID INT NOT NULL AUTO_INCREMENT ,
	SystemIdentifier varchar(100) NOT NULL ,
    BuildingID INT NOT NULL ,
    Area FLOAT NULL ,
	InsulationID INT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (WallID) );

call rheem.CreateIndexIfNotExists('designstar', 'Wall_idxSystemIdentifier', 'wall',  'SystemIdentifier', 'leaveUnchanged');

CREATE TABLE IF NOT EXISTS wallinsulation (
    WallInsulationID INT NOT NULL AUTO_INCREMENT ,
	SystemIdentifier varchar(100) NOT NULL ,
	WallID INT NOT NULL ,
    NominalRValue FLOAT NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (WallInsulationID) );		

call rheem.CreateIndexIfNotExists('designstar', 'WallInsulation_idxSystemIdentifier', 'wallinsulation',  'SystemIdentifier', 'leaveUnchanged');

CREATE TABLE IF NOT EXISTS window (
    WindowID INT NOT NULL AUTO_INCREMENT ,
	SystemIdentifier varchar(100) NOT NULL ,
    BuildingID INT NOT NULL ,
    UFactor FLOAT NULL ,
	SHGC FLOAT NULL ,
    Area FLOAT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (WindowID) );

call rheem.CreateIndexIfNotExists('designstar', 'Window_idxSystemIdentifier', 'window',  'SystemIdentifier', 'leaveUnchanged');

CREATE TABLE IF NOT EXISTS waterheater (
    WaterHeaterID INT NOT NULL AUTO_INCREMENT ,
	SystemIdentifier varchar(100) NOT NULL ,
    BuildingID INT NOT NULL ,
    FuelType varchar(100) NULL ,
	WaterHeaterType varchar(100) NULL ,
    EnergyFactor FLOAT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (WaterHeaterID) );

call rheem.CreateIndexIfNotExists('designstar', 'WaterHeater_idxSystemIdentifier', 'waterheater',  'SystemIdentifier', 'leaveUnchanged');

CREATE TABLE IF NOT EXISTS heatingsystem (
    HeatingSystemID INT NOT NULL AUTO_INCREMENT ,
	SystemIdentifier varchar(100) NOT NULL ,
    BuildingID INT NOT NULL ,
	HeatingSystemFuel varchar(100) NOT NULL ,
	HeatingCapacity FLOAT NOT NULL ,
	FractionHeatLoadServed bit NOT NULL DEFAULT 0 ,
	FloorAreaServed FLOAT NOT NULL ,
	SealedCombustionFurnace bit NOT NULL DEFAULT 0 ,
	AnnualHeatingEfficiencyUnits varchar(100) NOT NULL ,
	AnnualHeatingEfficiencyValue FLOAT NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (HeatingSystemID) );

call rheem.CreateIndexIfNotExists('designstar', 'HeatingSystem_idxSystemIdentifier', 'heatingsystem',  'SystemIdentifier', 'leaveUnchanged');

CREATE TABLE IF NOT EXISTS coolingsystem (
    CoolingSystemID INT NOT NULL AUTO_INCREMENT ,
	SystemIdentifier varchar(100) NOT NULL ,
    BuildingID INT NOT NULL ,
	CoolingSystemType varchar(100) NOT NULL ,
	CoolingSystemFuel varchar(100) NOT NULL ,
	CoolingCapacity FLOAT NOT NULL ,
	FractionCoolLoadServed bit NOT NULL DEFAULT 0 ,
	FloorAreaServed FLOAT NOT NULL ,
	SealedCombustionFurnace bit NOT NULL DEFAULT 0 ,
	AnnualCoolingEfficiencyUnits varchar(100) NOT NULL ,
	AnnualCoolingEfficiencyValue FLOAT NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (CoolingSystemID) );

call rheem.CreateIndexIfNotExists('designstar', 'CoolingSystem_idxSystemIdentifier', 'coolingsystem',  'SystemIdentifier', 'leaveUnchanged');

CREATE TABLE IF NOT EXISTS hvacdistribution (
    HVACDistributionID INT NOT NULL AUTO_INCREMENT ,
	SystemIdentifier varchar(100) NOT NULL ,
    BuildingID INT NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (HVACDistributionID) );

call rheem.CreateIndexIfNotExists('designstar', 'HVACDistribution_idxSystemIdentifier', 'hvacdistribution',  'SystemIdentifier', 'leaveUnchanged');

CREATE TABLE IF NOT EXISTS duct (
    DuctID INT NOT NULL AUTO_INCREMENT ,
    HVACDistributionID INT NOT NULL ,
    DuctLocation varchar(100) NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (DuctID) );

CREATE TABLE IF NOT EXISTS measure (
    MeasureID INT NOT NULL AUTO_INCREMENT ,
	SystemIdentifiersInfo varchar(100) NOT NULL ,
	ProjectID INT NOT NULL ,
	InstalledComponentID INT NULL ,
    MeasureDescription varchar(100) NULL ,
	Cost decimal(12, 2) NULL ,
	Status varchar(100) NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (MeasureID) );

CREATE TABLE IF NOT EXISTS energysavingsproject (
    EnergySavingsProjectID INT NOT NULL AUTO_INCREMENT ,
	ProjectID INT NOT NULL ,
	EnergySavingsType varchar(100) NULL ,
	EnergySavingsReported varchar(100) NULL ,
	DemandSavings float NULL ,
    AnnualPercentReduction float NULL ,
	Cost decimal(12, 2) NULL ,
	Status varchar(100) NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (EnergySavingsProjectID) );

CREATE TABLE IF NOT EXISTS energysavingsmeasure (
    EnergySavingsMeasureID INT NOT NULL AUTO_INCREMENT ,
	MeasureID INT NOT NULL ,
	EnergySavingsType varchar(100) NULL ,
	EnergySavingsReported varchar(100) NULL ,
	DemandSavings float NULL ,
    AnnualPercentReduction float NULL ,
	Cost decimal(12, 2) NULL ,
	Status varchar(100) NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (EnergySavingsMeasureID) );

call rheem.CreateIndexIfNotExists('designstar', 'Measure_idxSystemIdentifiersInfo', 'measure',  'SystemIdentifiersInfo', 'leaveUnchanged');

CREATE TABLE IF NOT EXISTS fuelsavingsmeasure (
    FuelSavingsMeasureID INT NOT NULL AUTO_INCREMENT ,
	MeasureID INT NOT NULL ,
    Fuel varchar(100) NULL ,
	Units varchar(100) NULL ,
	TotalSavings FLOAT NULL ,
	TotalDollarSavings decimal(12, 2) NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (FuelSavingsMeasureID) );

CREATE TABLE IF NOT EXISTS fuelsavingsproject (
    FuelSavingsProjectID INT NOT NULL AUTO_INCREMENT ,
	ProjectID INT NOT NULL ,
    Fuel varchar(100) NULL ,
	Units varchar(100) NULL ,
	TotalSavings FLOAT NULL ,
	TotalDollarSavings decimal(12, 2) NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (FuelSavingsProjectID) );

CREATE TABLE IF NOT EXISTS replacedcomponent (
    ReplacedComponentID INT NOT NULL AUTO_INCREMENT ,
	MeasureID INT NOT NULL ,
	SendingSystemIdentifierValue varchar(100) NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (ReplacedComponentID) );

CREATE TABLE IF NOT EXISTS installedcomponent (
    InstalledComponentID INT NOT NULL AUTO_INCREMENT ,
	MeasureID INT NOT NULL ,
	SendingSystemIdentifierValue varchar(100) NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (InstalledComponentID) );

CREATE TABLE IF NOT EXISTS utility (
	UtilityID INT NOT NULL AUTO_INCREMENT ,
	DesignStarParentID INT NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (UtilityID) );

CREATE TABLE IF NOT EXISTS utilityfuelprovider (
    UtilityFuelProviderID INT NOT NULL AUTO_INCREMENT ,
	UtilityID INT NOT NULL ,
	UtilityName varchar(100) NOT NULL ,
	MeterNumber INT NOT NULL ,
	SystemIdentifier varchar(100) NOT NULL ,
	ReceivingSystemIdentifierType varchar(100) NOT NULL ,
	ReceivingSystemIdentifierValue FLOAT NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (UtilityFuelProviderID) );

CREATE TABLE IF NOT EXISTS consumption (
    ConsumptionID INT NOT NULL AUTO_INCREMENT ,
	DesignStarParentID INT NOT NULL ,
	HPXML_BuildingID INT NOT NULL ,
	HPXML_CustomerID INT NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (ConsumptionID) );

CREATE TABLE IF NOT EXISTS consumptioninfo (
    ConsumptionInfoID INT NOT NULL AUTO_INCREMENT ,
	ConsumptionID INT NOT NULL ,
	HPXML_UtilityID varchar(100) NULL ,
	EnergyConsumptionID INT NULL ,
	WaterConsumptionID INT NULL ,
	ConsumptionDetailID INT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (ConsumptionInfoID) );

CREATE TABLE IF NOT EXISTS consumptioninfobuilding (
    ConsumptionInfoBuildingID INT NOT NULL AUTO_INCREMENT ,
	ConsumptionDetailID INT NULL ,
	HPXML_UtilityID varchar(100) NULL ,
	EnergyConsumptionID INT NULL ,
	WaterConsumptionID INT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (ConsumptionInfoBuildingID) );


CREATE TABLE IF NOT EXISTS energyconsumption (
    EnergyConsumptionID INT NOT NULL AUTO_INCREMENT ,
	FuelType varchar(100) NULL ,
	UnitOfMeasure varchar(100) NULL ,
	FuelInterruptibility varchar(100) NULL ,
	SharedEnergySystem varchar(100) NULL ,
	IntervalType varchar(100) NULL ,
	ReadingTimeZone varchar(100) NULL ,
	MarginalEnergyCostRate float NULL ,
	PeakSeason varchar(100) NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (EnergyConsumptionID) );
		
CREATE TABLE IF NOT EXISTS emissionfactor (
    EmissionFactorID INT NOT NULL AUTO_INCREMENT ,
	EnergyConsumptionID INT NOT NULL ,
	EmissionType varchar(100) NOT NULL ,
	EmissionUnits varchar(100) NOT NULL ,
	Emissions float NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (EmissionFactorID) );

CREATE TABLE IF NOT EXISTS waterconsumption (
    WaterConsumptionID INT NOT NULL AUTO_INCREMENT ,
	WaterType varchar(100) NOT NULL ,
	UnitOfMeasure varchar(100) NOT NULL ,
	MarginalWaterCostRate float NOT NULL ,
	WaterUseIntensityUnits varchar(100) NOT NULL ,
	WaterUseIntensityValue float NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (WaterConsumptionID) );
				
CREATE TABLE IF NOT EXISTS climateandriskzone (
    ClimateAndRiskZoneID INT NOT NULL AUTO_INCREMENT ,
	ClimateZoneDOE varchar(100) NULL ,
	ClimateZoneIECCYear INT NULL ,
	ClimateZoneIECCClimateZone varchar(100) NULL ,
	RadonZone INT NULL ,
	TermiteZone varchar(100) NULL ,
	HurricaneZone bit NOT NULL ,
	FloodZone bit NOT NULL ,
	EarthQuakeZone bit NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (ClimateAndRiskZoneID) );
				
CREATE TABLE IF NOT EXISTS zone (
    ZoneID INT NOT NULL AUTO_INCREMENT ,
	BuildingID INT NOT NULL ,
	SystemIdentifier varchar(100) NOT NULL ,
	ZoneName varchar(100) NOT NULL ,
	ZoneType varchar(100) NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (ZoneID) );
		
CREATE TABLE IF NOT EXISTS space (
    SpaceID INT NOT NULL AUTO_INCREMENT ,
	ZoneID INT NOT NULL ,
	SystemIdentifier varchar(100) NOT NULL ,
	NumberOfBedrooms INT NOT NULL ,
	FloorArea float NOT NULL ,
	Volume float NOT NULL ,
	CeilingHeight float NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (SpaceID) );
		
CREATE TABLE IF NOT EXISTS airinfiltrationmeasurement (
    AirInfiltrationMeasurementID INT NOT NULL AUTO_INCREMENT ,
	SystemIdentifier varchar(100) NOT NULL ,
	DateOfMeasurement DATETIME NOT NULL ,
	BusinessConductingTestSendingSystemIDType varchar(100) NULL ,
	BusinessConductingTestSendingSystemIDValue varchar(100) NULL ,
	BusinessConductingTestRcvingSystemIDType varchar(100) NULL ,
	BusinessConductingTestRcvingSystemIDValue varchar(100) NULL ,
	IndividualConductingTestSendingSystemIDType varchar(100) NULL ,
	IndividualConductingTestSendingSystemIDValue varchar(100) NULL ,
	IndividualConductingTestRcvingSystemIDType varchar(100) NULL ,
	IndividualConductingTestRcvingSystemIDValue varchar(100) NULL ,
	OutsideTemperature int NULL ,
	WindConditions varchar(100) NULL ,
	TypeOfInfiltrationMeasurement varchar(100) NULL ,
	TypeOfBlowerDoorTest varchar(100) NULL ,
	HousePressure float NULL ,
	FanPressure float NULL ,
	FanRingUsed varchar(100) NULL ,
	LeakinessDescription varchar(100) NULL ,
	BuildingAirLeakageUnitofMeasure varchar(100) NULL ,
	BuildingAirLeakageAirLeakage float NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (AirInfiltrationMeasurementID) );
		
CREATE TABLE IF NOT EXISTS airsealing (
    AirSealingID INT NOT NULL AUTO_INCREMENT ,
	BuildingID INT NOT NULL ,
	ComponentAirSealedName varchar(100) NOT NULL ,
	ComponentAirSealedValue varchar(100) NOT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (AirSealingID) );		
		
CREATE TABLE IF NOT EXISTS consumptiondetail (
    ConsumptionDetailID INT NOT NULL AUTO_INCREMENT ,
	Consumption float NULL ,
	StartDateTime DATETIME NULL ,
	EndDateTime DATETIME NULL ,
	ReadingType varchar(100) NULL ,
	ConsumptionCost float NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (ConsumptionDetailID) );		
		
CREATE TABLE IF NOT EXISTS roof (
    RoofID INT NOT NULL AUTO_INCREMENT ,
	BuildingID INT NOT NULL ,
	SystemIdentifier varchar(100) NOT NULL ,
	AttachedToSpaceREFID varchar(100) NULL ,
	RoofColor varchar(100) NULL ,
	RoofType varchar(100) NULL ,
	DeckType varchar(100) NULL ,
	Pitch float NULL ,
	RoofArea float NULL ,
	RadiantBarrier bit NULL ,
	RadiantBarrierLocation varchar(100) NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (RoofID) );		

CREATE TABLE IF NOT EXISTS foundation (
    FoundationID INT NOT NULL AUTO_INCREMENT ,
	BuildingID INT NOT NULL ,
	SystemIdentifier varchar(100) NOT NULL ,
	AttachedToSpaceREFID varchar(100) NULL ,
	FoundationType varchar(100) NULL ,
	FoundationSpaceFinished bit NULL ,
	FoundationSpaceConditioned bit NULL ,
	ThermalBoundary varchar(100) NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (FoundationID) );		
		
CREATE TABLE IF NOT EXISTS framefloor (
    FrameFloorID INT NOT NULL AUTO_INCREMENT ,
	FoundationID INT NOT NULL ,
	SystemIdentifier varchar(100) NOT NULL ,
	FloorJoistSize varchar(100) NULL ,
	FloorJoistSpacing float NULL ,
	FloorJoistFramingFactor float NULL ,
	FloorJoistMaterial varchar(100) NULL ,
	FloorCovering varchar(100) NULL ,
	Area float NULL ,
	InsulationID INT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (FrameFloorID) );		

CREATE TABLE IF NOT EXISTS insulation (
    InsulationID INT NOT NULL AUTO_INCREMENT ,
	SystemIdentifier varchar(100) NOT NULL ,
	InsulationGrade INT NULL ,
	InsulationCondition varchar(100) NULL ,
	InstallationType varchar(100) NULL ,
	InsulationMaterialType varchar(100) NULL ,
	InsulationMaterialDesc varchar(100) NULL ,
	NominalRValue float NULL ,
	Thickness float NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (InsulationID) );		
		
CREATE TABLE IF NOT EXISTS foundationwall (
    FoundationWallID INT NOT NULL AUTO_INCREMENT ,
	FoundationID INT NOT NULL ,
	SystemIdentifier varchar(100) NOT NULL ,
	WallType varchar(100) NULL ,
	Thickness float NULL ,
	InteriorStudSize varchar(100) NULL ,
	InteriorStudSpacing float NULL ,
	InteriorStudFramingFactor float NULL ,
	InteriorStudMaterial varchar(100) NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (FoundationWallID) );		
		
CREATE TABLE IF NOT EXISTS slab (
    SlabID INT NOT NULL AUTO_INCREMENT ,
	FoundationID INT NOT NULL ,
	SystemIdentifier varchar(100) NOT NULL ,
	UnderSlabInsulationWidth float NULL ,
	OnGradeExposedPerimeter float NULL ,
	DepthBelowGrade float NULL ,
	FloorCovering varchar(100) NULL ,
	PerimeterInsulationID INT NULL ,
	UnderSlabInsulationID INT NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (SlabID) );		

CREATE TABLE IF NOT EXISTS rimjoist (
    RimJoistID INT NOT NULL AUTO_INCREMENT ,
	BuildingID INT NOT NULL ,
	SystemIdentifier varchar(100) NOT NULL ,
	AttachedToSpaceREFID varchar(100) NULL ,
	ExteriorAdjacentTo varchar(100) NULL ,
	InteriorAdjacentTo varchar(100) NULL ,
	Area float NULL ,
	InsulationID INT NULL ,
	FloorJoistSize varchar(100) NULL ,
	FloorJoistSpacing float NULL ,
	FloorJoistFramingFactor float NULL ,
	FloorJoistMaterial varchar(100) NULL ,
	ConsumptionInfoBuildingID INT NULL ,	
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (RimJoistID) );		

CREATE TABLE IF NOT EXISTS heatpump (
    HeatPumpID INT NOT NULL AUTO_INCREMENT ,
	BuildingID INT NOT NULL ,
    ConsumptionInfoBuildingID INT NULL ,
	SystemIdentifier varchar(100) NULL ,
    HeatPumpType varchar(100) NULL ,
    HeatingCapacity float NULL ,
    CoolingCapacity float NULL ,
    FractionHeatLoadServed float NULL ,
    FractionCoolLoadServed float NULL ,
    FloorAreaServed float NULL ,
    AnnualCoolEfficiencyUnits varchar(100) NULL ,
    AnnualCoolEfficiencyValue float NULL ,
    AnnualHeatEfficiencyUnits varchar(100) NULL ,
    AnnualHeatEfficiencyValue float NULL ,
    CreateDateTime__Gen DATETIME NOT NULL,
    UpdateDateTime__Gen DATETIME NOT NULL,
		PRIMARY KEY (HeatPumpID) );		

call rheem.CreateForeignKeyIfNotExists('designstar', 'RimJoistFK1', 'rimjoist', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'RimJoistFK2', 'rimjoist', 'InsulationID', 'insulation', 'InsulationID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'RimJoistFK3', 'rimjoist', 'ConsumptionInfoBuildingID', 'consumptioninfobuilding', 'ConsumptionInfoBuildingID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'SlabFK1', 'slab', 'PerimeterInsulationID', 'insulation', 'InsulationID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'SlabFK2', 'slab', 'UnderSlabInsulationID', 'insulation', 'InsulationID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'SlabFK3', 'slab', 'FoundationID', 'foundation', 'FoundationID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'FoundationWallFK1', 'foundationwall', 'FoundationID', 'foundation', 'FoundationID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'FrameFloorFK1', 'framefloor', 'FoundationID', 'foundation', 'FoundationID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'FrameFloorFK2', 'framefloor', 'InsulationID', 'insulation', 'InsulationID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'FoundationFK1', 'foundation', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'ConsumptionInfoBuildingFK1', 'consumptioninfobuilding', 'EnergyConsumptionID', 'energyconsumption', 'EnergyConsumptionID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'ConsumptionInfoBuildingFK2', 'consumptioninfobuilding', 'WaterConsumptionID', 'waterconsumption', 'WaterConsumptionID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'ConsumptionInfoBuildingFK3', 'consumptioninfobuilding', 'ConsumptionDetailID', 'consumptiondetail', 'ConsumptionDetailID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'AirSealingFK1', 'airsealing', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'SpaceFK1', 'space', 'ZoneID', 'zone', 'ZoneID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'ZoneFK1', 'zone', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'TelephoneFK1', 'telephone', 'PersonID', 'person', 'PersonID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'EmissionFactorFK1', 'emissionfactor', 'EnergyConsumptionID', 'energyconsumption', 'EnergyConsumptionID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'ConsumptionFK1', 'consumption', 'DesignStarParentID', 'designstarparent', 'DesignStarParentID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'ConsumptionInfoFK1', 'consumptioninfo', 'ConsumptionID', 'consumption', 'ConsumptionID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'ConsumptionInfoFK2', 'consumptioninfo', 'EnergyConsumptionID', 'energyconsumption', 'EnergyConsumptionID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'ConsumptionInfoFK3', 'consumptioninfo', 'WaterConsumptionID', 'waterconsumption', 'WaterConsumptionID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'ConsumptionInfoFK4', 'consumptioninfo', 'ConsumptionDetailID', 'consumptiondetail', 'ConsumptionDetailID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'CustomerFK1', 'customer', 'PersonID', 'person', 'PersonID', 'dropAndReplace', NULL);
call rheem.CreateForeignKeyIfNotExists('designstar', 'CustomerFK2', 'customer', 'MailingAddressID', 'mailingaddress', 'MailingAddressID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'CustomerFK3', 'customer', 'DesignStarParentID', 'designstarparent', 'DesignStarParentID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'ProjectFK1', 'project', 'DesignStarParentID', 'designstarparent', 'DesignStarParentID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'PhonePersonFK1', 'phoneperson', 'PersonID', 'person', 'PersonID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'BuildingFK1', 'building', 'DesignStarParentID', 'designstarparent', 'DesignStarParentID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'BuildingFK2', 'building', 'ClimateAndRiskZoneID', 'climateandriskzone', 'ClimateAndRiskZoneID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'BuildingFK3', 'building', 'AirInfiltrationMeasurementID', 'airinfiltrationmeasurement', 'AirInfiltrationMeasurementID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'BuildingFK4', 'building', 'ConsumptionInfoBuildingID', 'consumptioninfobuilding', 'ConsumptionInfoBuildingID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'MeasureFK1', 'measure', 'ProjectID', 'project', 'ProjectID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'MeasureFK2', 'measure', 'InstalledComponentID', 'installedcomponent', 'InstalledComponentID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'AtticFK1', 'attic', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'AtticFK2', 'attic', 'InsulationID', 'insulation', 'InsulationID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'RoofFK1', 'roof', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'WallFK1', 'wall', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'WallFK2', 'wall', 'InsulationID', 'insulation', 'InsulationID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'WindowFK1', 'window', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'WaterHeaterFK1', 'waterheater', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'DuctFK1', 'duct', 'HVACDistributionID', 'hvacdistribution', 'HVACDistributionID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'ReplacedComponentFK1', 'replacedcomponent', 'MeasureID', 'measure', 'MeasureID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'WallInsulationFK1', 'wallinsulation', 'WallID', 'wall', 'WallID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'UtilityFK1', 'utility', 'DesignStarParentID', 'designstarparent', 'DesignStarParentID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'UtilityFuelProviderFK1', 'utilityfuelprovider', 'UtilityID', 'utility', 'UtilityID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'HeatPumpFK1', 'heatpump', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');
call rheem.CreateForeignKeyIfNotExists('designstar', 'HeatPumpFK2', 'heatpump', 'ConsumptionInfoBuildingID', 'consumptioninfobuilding', 'ConsumptionInfoBuildingID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'HeatingSystemFK2', 'heatingsystem', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'CoolingSystemFK2', 'coolingsystem', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'HvacDistributionFK2', 'hvacdistribution', 'BuildingID', 'building', 'BuildingID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'EnergySavingsProjectFK1', 'energysavingsproject', 'ProjectID', 'project', 'ProjectID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'EnergySavingsMeasureFK1', 'energysavingsmeasure', 'MeasureID', 'measure', 'MeasureID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'FuelSavingsProjectFK1', 'fuelsavingsproject', 'ProjectID', 'project', 'ProjectID', 'dropAndReplace', 'ON DELETE CASCADE');		
call rheem.CreateForeignKeyIfNotExists('designstar', 'FuelSavingsMeasureFK1', 'fuelsavingsmeasure', 'MeasureID', 'measure', 'MeasureID', 'dropAndReplace', 'ON DELETE CASCADE');		
