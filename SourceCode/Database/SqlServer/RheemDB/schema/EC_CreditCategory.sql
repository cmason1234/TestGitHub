Use [RheemDB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_CreditCategory') AND type in (N'U'))
BEGIN
drop table ec_CreditCategory
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_CreditCategoryUnitsByMonth') AND type in (N'U'))
BEGIN

  drop TABLE EC_CreditCategoryUnitsByMonth
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_CreditCategoryNames') AND type in (N'U'))
BEGIN
  drop table ec_creditcategoryNames
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_CreditProductDescriptionValue') AND type in (N'U'))
BEGIN
   Drop Table EC_CreditProductDescriptionValue
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_CreditMarketingCode') AND type in (N'U'))
BEGIN
 CREATE TABLE [dbo].[EC_CreditMarketingCode](
	[CreditMarketingCodeID] [uniqueidentifier] NOT NULL,
	[MarketingCode] [varchar](50) NULL,
	IsActive bit NOT NULL,
	CONSTRAINT PK_EC_CreditMarketingCode PRIMARY KEY CLUSTERED 
		(
			CreditMarketingCodeID ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
		ON [PRIMARY]
	) ON [PRIMARY]
END
GO

if NOT EXISTS(select * from sys.columns where Name = N'SortOrder'  
            and Object_ID = Object_ID(N'EC_CreditMarketingCode'))
BEGIN
	ALTER TABLE EC_CreditMarketingCode ADD SortOrder int NOT NULL default 0;	
END


if NOT EXISTS(select * from sys.columns where Name = N'IncludeInTotals'  
            and Object_ID = Object_ID(N'EC_CreditMarketingCode'))
BEGIN
	ALTER TABLE EC_CreditMarketingCode ADD IncludeInTotals bit NOT NULL default 1;	
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_CreditProductDescription') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EC_CreditProductDescription](
		[CreditProductDescriptionID] [uniqueidentifier] NOT NULL,
		[ProductDescription] [varchar](50) NULL,
		[CreditMarketingCodeID] [uniqueidentifier] NULL,
		CONSTRAINT [PK_EC_CreditProductDescription] PRIMARY KEY CLUSTERED 
			(
				CreditProductDescriptionID ASC
			)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
			ON [PRIMARY],
		CONSTRAINT FK_EC_CreditProductDescription_1 FOREIGN KEY (CreditMarketingCodeID) 
			references EC_CreditMarketingCode(CreditMarketingCodeID) ON DELETE CASCADE
	) ON [PRIMARY]
END
GO

if NOT EXISTS(select * from sys.columns where Name = N'IsActive'  
            and Object_ID = Object_ID(N'EC_CreditProductDescription'))
BEGIN
	ALTER TABLE EC_CreditProductDescription ADD IsActive Bit Not Null Default 1;	
END
GO

if NOT EXISTS(select * from sys.columns where Name = N'SortOrder'  
            and Object_ID = Object_ID(N'EC_CreditProductDescription'))
BEGIN
	ALTER TABLE EC_CreditProductDescription ADD SortOrder int NOT NULL default 0;	
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_CreditRebateNames') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EC_CreditRebateNames](
		[CreditRebateNamesID] [uniqueidentifier] NOT NULL,
		[RebateName] [varchar] (50) not NULL,
		[GDPYear] int not null,
		[StartDate] datetime null,
		[EndDate] datetime  null,
		CONSTRAINT [PK_EC_CreditRebateName] PRIMARY KEY CLUSTERED 
			(
				CreditRebateNamesID ASC
			)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
			ON [PRIMARY]
	) ON [PRIMARY]
END
GO

if NOT EXISTS(select * from sys.columns where Name = N'IsActive'  
            and Object_ID = Object_ID(N'EC_CreditRebateNames'))
BEGIN
	ALTER TABLE EC_CreditRebateNames ADD IsActive Bit Not Null Default 1;	
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_CreditRebateAmounts') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[EC_CreditRebateAmounts](
		[CreditRebateAmountsID] [uniqueidentifier] NOT NULL,
		[CreditRebateNamesID] [uniqueidentifier] NOT NULL,
		[CreditProductDescriptionID] [uniqueidentifier] NOT NULL,
		[RebateAmount] [decimal] (2) not null,
		CONSTRAINT [PK_EC_CreditRebateAmounts] PRIMARY KEY CLUSTERED 
			(
				CreditRebateAmountsID ASC
			)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
			ON [PRIMARY],
		CONSTRAINT FK_EC_CreditRebateAmounts_1 FOREIGN KEY (CreditRebateNamesID) 
			references EC_CreditRebateNames(CreditRebateNamesID),
		CONSTRAINT FK_EC_CreditRebateAmounts_2 FOREIGN KEY (CreditProductDescriptionID) 
			references EC_CreditProductDescription(CreditProductDescriptionID),
	) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_CreditOrgsWithRebateAmount') AND type in (N'U'))
BEGIN
	CREATE TABLE EC_CreditOrgsWithRebateAmount(
		[CreditOrgsWithRebateAmountID] [uniqueidentifier] NOT NULL,
		[CreditRebateNamesID] [uniqueidentifier] NOT NULL,
		[OrganizationID] [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_EC_CreditOrgsWithRebateAmount] PRIMARY KEY CLUSTERED 
			(
				CreditOrgsWithRebateAmountID ASC
			)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
			ON [PRIMARY],
		CONSTRAINT FK_EC_CreditOrgsWithRebateAmount_1 FOREIGN KEY (CreditRebateNamesID) 
			references EC_CreditRebateNames(CreditRebateNamesID)
	) ON [PRIMARY]
END
GO

if EXISTS(select * from sys.columns where Name = N'CreditProductDescriptionValueID'  
            and Object_ID = Object_ID(N'EC_CreditUnitsByMonth'))
BEGIN
	DROP table EC_CreditUnitsByMonth
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_CreditUnitsByMonth') AND type in (N'U'))
BEGIN
	CREATE TABLE EC_CreditUnitsByMonth(
		CreditUnitsByMonthID uniqueidentifier NOT NULL,
		GDPYear int NOT NULL,
		GDPMonth varchar(50) NOT NULL,
		OrganizationID UniqueIdentifier NOT NULL,
		CreditRebateAmountsID uniqueidentifier NOT NULL,
		Units int NOT NULL,
		RebateTotal decimal(18, 2) NOT NULL,
		CONSTRAINT PK_EC_CreditUnitsByMonth PRIMARY KEY CLUSTERED 
		(
			CreditUnitsByMonthID ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
		ON [PRIMARY],
		CONSTRAINT UK1_EC_CreditUnitsByMonth UNIQUE
		(
			GDPYear, GDPMonth, CreditRebateAmountsID
		),
		CONSTRAINT FK_EC_CreditUnitsByMonth_1 FOREIGN KEY (CreditRebateAmountsID) 
				references EC_CreditRebateAmounts(CreditRebateAmountsID)
	) ON [PRIMARY]
END
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE name='UK1_EC_CreditUnitsByMonth' 
           AND object_id = OBJECT_ID('EC_CreditUnitsByMonth'))
BEGIN
     ALTER TABLE EC_CreditUnitsByMonth DROP CONSTRAINT UK1_EC_CreditUnitsByMonth
	 CREATE UNIQUE INDEX UK1_EC_CreditUnitsByMonthWithOrg on 
	   EC_CreditUnitsByMonth(GDPYear, GDPMonth, OrganizationID, CreditRebateAmountsID)
END
GO

if NOT EXISTS(select * from sys.columns where Name = N'RebatePerUnit'  
            and Object_ID = Object_ID(N'EC_CreditUnitsByMonth'))
BEGIN
	Alter Table EC_CreditUnitsByMonth ADD RebatePerUnit decimal(18, 2) NOT NULL;	
END
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_FundingGuide') AND type in (N'U'))
BEGIN
	CREATE TABLE EC_FundingGuide(
		FundingGuideID uniqueidentifier NOT NULL,
		GDPYear int NOT NULL,
		OrganizationID UniqueIdentifier NOT NULL,
		PriorYearRetailUnits Integer,
		CurrYearRetailUnitsGrowth Integer,
		CurrYearRetailTotalUnits Integer,
		GDPFundingEst  decimal(18, 2),
		TCFundingEst  decimal(18, 2),
		TotalEst decimal(18, 2),
		PrevYearTotalUnits integer,
		CurrYearForecastedTotalUnits integer,
		PrevYearTotalCoop decimal(18, 2),
		CurrYearTotalCoop decimal(18, 2),
		CONSTRAINT PK_EC_EC_FundingGuide PRIMARY KEY CLUSTERED 
		(
			FundingGuideID ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
		ON [PRIMARY],
		CONSTRAINT UK1_EC_FundingGuide UNIQUE
		(
			GDPYear, OrganizationID
		)
	) ON [PRIMARY]
END
GO




IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'EC_FundingGuideDetail') AND type in (N'U'))
BEGIN
	CREATE TABLE EC_FundingGuideDetail(
		FundingGuideDetailID uniqueidentifier NOT NULL,
		FundingGuideID uniqueidentifier NOT NULL,
		CreditRebateAmountsID uniqueidentifier NOT NULL,
		PrevYearUnits int NOT NULL,
		PrevYearRebateTotal decimal(18, 2) NOT NULL,
		PrevYearMixPercent decimal(9, 5) NOT NULL,
		CurrYearUnits int NOT NULL,
		CurrYearRebateTotal decimal(18, 2) NOT NULL,
		CurrYearMixPercent decimal(9, 5) NOT NULL,		
		CONSTRAINT PK_EC_EC_FundingGuideDetail PRIMARY KEY CLUSTERED 
		(
			FundingGuideDetailID ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
		ON [PRIMARY],
		CONSTRAINT FK_EC_FundingGuideDetail_1 FOREIGN KEY (FundingGuideID) 
				references EC_FundingGuide(FundingGuideID),
		CONSTRAINT FK_EC_FundingGuideDetail_2 FOREIGN KEY (CreditRebateAmountsID) 
				references EC_CreditRebateAmounts(CreditRebateAmountsID)
	) ON [PRIMARY]
END
GO
