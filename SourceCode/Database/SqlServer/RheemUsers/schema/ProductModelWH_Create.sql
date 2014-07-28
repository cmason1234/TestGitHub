USE RheemUsers


-- --------------
-- ProductModelWH 
-- --------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductModelWH') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[ProductModelWH](
	[ProductModelWHID] [uniqueidentifier] NOT NULL Default newid(),
	[ProductID]        [uniqueidentifier] NOT NULL Constraint FK_ProductModelWH_Product_ProductID Foreign Key references Product(ProductID) on delete cascade,
	[Model]            [varchar](50) NOT NULL,
	[TanklessGas]         [bit] NOT NULL default 0,
	[TanklessElectric]    [bit] NOT NULL default 0,
	[TankGas]             [bit] NOT NULL default 0,
	[TankElectic]         [bit] NOT NULL default 0,
	[ManufacturedHousing] [bit] NOT NULL default 0,
	[Solar]               [bit] NOT NULL default 0,
	[Indirect]            [bit] NOT NULL default 0,
	[CreateDateTime__Gen] [datetime]  NULL,
	[UpdateDateTime__Gen] [datetime]  NULL,
 CONSTRAINT [PK_ProductModelWH] PRIMARY KEY CLUSTERED (	[ProductModelWHID] ASC)
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]	
END
GO


-- ------------------
-- ProductModelWHTank
-- ------------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductModelWHTank') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[ProductModelWHTank](
	[ProductModelWHTankID] [uniqueidentifier] NOT NULL Default newid(),
	[ProductModelWHID] [uniqueidentifier] NOT NULL Constraint FK_ProductModelWHTank_ProductModelWH_ProductModelWHID Foreign Key references ProductModelWH(ProductModelWHID) on delete cascade,
	[TankType] [varchar](50),	
	[GallonCapacity]   [decimal](3,1)  NOT NULL default 0, 		
	[GasInputNatural]  [decimal](3,1)   NOT NULL default 0,
	[GasInputLP]       [decimal](3,1)   NOT NULL default 0,
	[RecoveryNatural]  [decimal](3,1)   NOT NULL default 0,
	[RecoveryLP]       [decimal](3,1)   NOT NULL default 0,	
	[RecoveryGPMNinetyRiseat3500] [integer]  NOT NULL default 0,	
	[RecoveryGPMNinetyRiseat4500] [integer]  NOT NULL default 0,	
	[FirstHourNatural]       [integer] NOT NULL default 0,
	[FirstHourLP]            [integer] NOT NULL default 0,	
	[FirstHourElectric]            [integer] NOT NULL default 0,	
	[FirstHourGPMat3500]     [integer] NOT NULL default 0,	
	[FirstHourGPMat4500]     [integer] NOT NULL default 0,	
	[HeightToVent]           [integer]  NOT NULL default 0,
	[TankHeight]             [integer]  NOT NULL default 0,
	[TankWidth]              [integer]  NOT NULL default 0,
	[Diameter]               [integer]  NOT NULL default 0,	
	[HeightToGasConnector]   [integer]   NOT NULL default 0,	
	[VentSize]               [varchar](50),	
	[WaterConnectorCenter]   [integer] NOT NULL default 0,
	[HeightToSideTap]        [integer]   NOT NULL default 0,
	[WaterConnector]         [integer]   NOT NULL default 0,	
	[ShipWeight]             [integer] NOT NULL default 0,	
	[EnergyFactorNatural]    [decimal](3,2)   NOT NULL default 0,
	[EnergyFactorLP]         [decimal](3,2)   NOT NULL default 0,
	[EnergyFactorElectric]        [decimal](3,2)   NOT NULL default 0,
	[AnnualOperatingCostNatural]  [integer] NOT NULL default 0,
	[AnnualOperatingCostLP]       [integer] NOT NULL default 0,
	[AnnualOperatingCostElectric] [integer] NOT NULL default 0,
	[HeightToAirInlet]       [integer] NOT NULL default 0,	
	[FrontToBack]            [integer]   NOT NULL default 0,
	[HeighttoTopOfAssembly]  [integer]   NOT NULL default 0,
	[AltitudeRatingNatural]  [integer] NOT NULL default 0,
	[AltitudeRatingLP]       [integer] NOT NULL default 0,
	[Venting]                [varchar](50),	
	[SideVentingWithKitMin]         [integer]   NOT NULL default 0,
	[SideVentingWithKitMax]	        [integer]   NOT NULL default 0,	
	[SideVentingWithOptionalKitMin] [integer]   NOT NULL default 0,
	[SideVentingWithOptionalKitMax] [integer]   NOT NULL default 0,	
	[OptionalHeightWithVentKitMin]  [integer]   NOT NULL default 0,
	[OptionalHeightWithVentKitMax]  [integer]   NOT NULL default 0,
	[FirstHourGPM]           [integer] NOT NULL default 0,		
	[RecoveryGPMNinetyRise]  [integer]  NOT NULL default 0,	
	[HeightToWaterConnector] [integer]   NOT NULL default 0,	
	[EnergySaver]            [varchar](50) NOT NULL default 0,	
	[Wattage]                [integer] NOT NULL default 0,
	[Voltage]                [integer] NOT NULL default 0,	
	[HeightToWaterOutlet]    [integer] NOT NULL default 0,
	[HeightToWaterInlet]     [integer] NOT NULL default 0,
	[RoofJackVent]           [integer] NOT NULL default 0,
	[CreateDateTime__Gen] [datetime]  NULL,
	[UpdateDateTime__Gen] [datetime]  NULL,
 CONSTRAINT [PK_ProductModelWHTank] PRIMARY KEY CLUSTERED (	[ProductModelWHTankID] ASC)
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]	
END
GO




-- ----------------------
-- ProductModelWHTankless
-- ----------------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductModelWHTankless') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[ProductModelWHTankless](
	[ProductModelWHTanklessID] [uniqueidentifier] NOT NULL Default newid(),
	[ProductModelWHID] [uniqueidentifier] NOT NULL Constraint FK_ProductModelWHTankless_ProductModelWH_ProductModelWHID Foreign Key references ProductModelWH(ProductModelWHID) on delete cascade,
	[WHType] [varchar](50), 
	[GasInputBTUMin] [integer] NOT NULL default 0,
	[GasInputBTUMax] [integer] NOT NULL default 0,
	[TempRangeMin]   [integer] NOT NULL default 0,
	[TempRangeMax]   [integer] NOT NULL default 0,
	[MinFlow]                [decimal](3,2) NOT NULL default 0,
	[ActivationGPM]          [decimal](3,2) NOT NULL default 0,
	[GPMSeventySevenRiseMax] [decimal](2,1) NOT NULL default 0,
	[GPMFortyFiveRiseMax]    [decimal](2,1) NOT NULL default 0,
	[GPMThirtyFiveRiseMax]   [decimal](2,1) NOT NULL default 0,
	[MaxGPM]                 [decimal](2,1) NOT NULL default 0,
	[ConnectionWater]   [integer] NOT NULL default 0,
	[ConnectionGas]     [integer] NOT NULL default 0,
	[Height]            [integer] NOT NULL default 0,
	[Length]            [integer] NOT NULL default 0,
	[Depth]             [integer] NOT NULL default 0,
	[VentDiamter]       [varchar](50) NULL,
	[ShipWeight]        [integer] NOT NULL default 0,
	[EnergyFactor]      [decimal](3,2)  NOT NULL default 0,
	[ThermalEfficiency] [integer] NOT NULL default 0,
	[AnnualCostGas]     [decimal](5,2)  NOT NULL default 0,
	[AnnualCostLP]      [decimal](5,2)  NOT NULL default 0,
	[CreateDateTime__Gen] [datetime]  NULL,
	[UpdateDateTime__Gen] [datetime]  NULL,
 CONSTRAINT [PK_ProductModelWHTankless] PRIMARY KEY CLUSTERED (	[ProductModelWHTanklessID] ASC)
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]	
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductModelWHSolar') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[ProductModelWHSolar](
	[ProductModelWHSolarID] [uniqueidentifier] NOT NULL Default newid(),
	[ProductModelWHID] [uniqueidentifier] NOT NULL Constraint FK_ProductModelWHSolar_ProductModelWH_ProductModelWHID Foreign Key references ProductModelWH(ProductModelWHID) on delete cascade,
	[StorageCapacity]   [integer] NOT NULL default 0,
	[SolarEnergyFactor] [decimal] (2,1) NOT NULL default 0,
	[NumberOfCollectionPanels] [integer] NOT NULL default 0,
	[AbsorberCoating] [varchar](50), 
	[CollectorWidth]  [integer] NOT NULL default 0,
	[CollectorLength] [integer] NOT NULL default 0,
	[CollectorDepth]  [integer] NOT NULL default 0,
	[AreaSqFt]        [decimal](5,2) NOT NULL default 0,
	[DryWeight]       [integer] NOT NULL default 0,	
	[FluidCapacity]   [decimal](2,1) NOT NULL default 0,	
	[DesignFlowRate]       [decimal](3,2) NOT NULL default 0,
	[MaxFlowRate]          [integer] NOT NULL default 0,
	[MaxOperatingPressure] [integer] NOT NULL default 0,
	[TankHeight]           [integer] NOT NULL default 0,
	[TankDiameter]         [integer] NOT NULL default 0,
	[TankWeight]           [integer] NOT NULL default 0,
	[TankWattage]          [integer] NOT NULL default 0,
	[BTUInput]             [decimal](3,1) NOT NULL default 0,	
	[WorkingPressure]      [integer] NOT NULL default 0,
    [DeliveryCapacity]     [decimal](3,1) NOT NULL default 0,
	[BackUpelementSpecs]   [varchar](50) NOT NULL default 0,
	[SystemWidth]       [integer] NOT NULL default 0,
	[SystemLength]      [integer] NOT NULL default 0,
	[SystemWeightEmpty] [integer] NOT NULL default 0,
	[SystemWeightFull]  [integer] NOT NULL default 0,
	[CreateDateTime__Gen] [datetime]  NULL,
	[UpdateDateTime__Gen] [datetime]  NULL,
 CONSTRAINT [PK_ProductModelWHSolar] PRIMARY KEY CLUSTERED (	[ProductModelWHSolarID] ASC)
	WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]	
END
GO





			