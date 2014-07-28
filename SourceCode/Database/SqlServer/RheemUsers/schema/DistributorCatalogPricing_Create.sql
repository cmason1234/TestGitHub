USE RheemUsers
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DistributorCatalogPricingNames') AND type in (N'U'))
BEGIN

	CREATE TABLE DistributorCatalogPricingNames (
		DistributorCatalogPricingNamesID uniqueidentifier NOT NULL,
		OrganizationID uniqueidentifier NOT NULL CONSTRAINT FK_DisCatPriceNames_1 
		            references Organization(OrganizationID) ON DELETE CASCADE,
		BrandID UniqueIdentifier NOT NULL,
		PricingName varchar(1000) NOT NULL,
		Remarks Varchar(4000),
		IsActive bit NOT NULL Default 1,
		IsPublic bit NOT NULL Default 1,
		CreateDateTime__Gen datetime NULL,
		UpdateDateTime__Gen datetime NULL,
	 CONSTRAINT PK_DistributorCatalogPricingNames PRIMARY KEY CLUSTERED 
	(
		DistributorCatalogPricingNamesID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
	
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DistributorCatalogPricing') AND type in (N'U'))
BEGIN

	CREATE TABLE DistributorCatalogPricing (
		DistributorCatalogPricingID uniqueidentifier NOT NULL,
		DistributorCatalogPricingNamesID uniqueidentifier NOT NULL CONSTRAINT FK_DistCatPri_DistCatPricNames 
		  FOREIGN KEY(DistributorCatalogPricingNamesID) REFERENCES
		  DistributorCatalogPricingNames (DistributorCatalogPricingNamesID) ON DELETE CASCADE,
		ProductModelID uniqueidentifier NOT NULL CONSTRAINT FK_DistCatPri_ProdModel
		  FOREIGN KEY (ProductModelID) REFERENCES ProductModel(ProductModelID) ON DELETE CASCADE,
		ModelCost float Null,
		IsActive bit NOT NULL Default 1,
		CreateDateTime__Gen datetime NULL,
		UpdateDateTime__Gen datetime NULL,
	 CONSTRAINT PK_DistributorCatalogPricing PRIMARY KEY CLUSTERED 
	(
		DistributorCatalogPricingID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END	
GO

if NOT EXISTS(select * from sys.columns where Name = N'UseRemark'  
            and Object_ID = Object_ID(N'DistributorCatalogPricing'))
ALTER TABLE DistributorCatalogPricing ADD UseRemark bit NOT NULL default 0
GO

if NOT EXISTS(select * from sys.columns where Name = N'Remark'  
            and Object_ID = Object_ID(N'DistributorCatalogPricing'))
ALTER TABLE DistributorCatalogPricing ADD Remark Varchar(20) NULL
GO

