USE [RheemUsers]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductLog') AND type in (N'U'))
BEGIN
	CREATE TABLE ProductLog(
		ProductLogID uniqueidentifier NOT NULL,
		ProductID uniqueidentifier NULL,
		SeqID int NULL,
		LogText varchar(1024) NULL,
		CreateDateTime__Gen datetime NULL,
		UpdateDateTime__Gen datetime NULL,
	 CONSTRAINT PK_ProductLog PRIMARY KEY CLUSTERED 
	(
		ProductLogID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE ProductLog  WITH CHECK ADD  CONSTRAINT FK_ProductLog_ProductID FOREIGN KEY(ProductID)
	REFERENCES Product (ProductID) ON DELETE CASCADE

	ALTER TABLE ProductLog CHECK CONSTRAINT [FK_ProductLog_ProductID]
	EXEC('Insert Into ProductLog Select * from PRODUCTS..ProductLog pl where pl.ProductID in (Select ProductID from rheemusers..Product)')
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductNotes') AND type in (N'U'))
BEGIN
	CREATE TABLE ProductNotes(
		ProductNoteID uniqueidentifier NOT NULL,
		ProductID uniqueidentifier NULL,
		NoteType varchar(50) NULL,
		Note text NULL,
		DateAdded datetime NULL,
		CreateDateTime__Gen datetime NULL,
		UpdateDateTime__Gen datetime NULL,
	 CONSTRAINT PK_ProductNotes PRIMARY KEY CLUSTERED 
	(
		ProductNoteID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

	ALTER TABLE ProductNotes  WITH CHECK ADD  CONSTRAINT FK_ProductNotes_ProductID FOREIGN KEY(ProductID)
	REFERENCES Product (ProductID)
	ON DELETE CASCADE

	ALTER TABLE ProductNotes CHECK CONSTRAINT FK_ProductNotes_ProductID
	
	EXEC('Insert Into ProductNotes Select * from PRODUCTS..ProductNotes pn where pn.ProductID in (Select ProductID from rheemusers..Product)')
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductCategory') AND type in (N'U'))
BEGIN
	CREATE TABLE dbo.ProductCategory(
		ProductCategoryID uniqueidentifier NOT NULL,
		CategoryName varchar(50) NULL,
		Model bit NULL,
		Market bit NULL,
		Brand bit NULL,
		Series bit NULL,
		Description bit NULL,
		GasEfficiency bit NULL,
		HSPF bit NULL,
		ComfortControl bit NULL,
		ComfortControl2 bit NULL,
		Gamma bit NULL,
		SEER bit NULL,
		Tonnages bit NULL,
		CabinetSize bit NULL,
		ARI210240 bit NULL,
		UL bit NULL,
		R410A bit NULL,
		EnergyGuide bit NULL,
		EnergyStar bit NULL,
		EnergyMiser bit NULL,
		CSA bit NULL,
		SACC bit NULL,
		EIL bit NULL,
		NSF bit NULL,
		HLW bit NULL,
		SCAQMD bit NULL,
		ProductCopy bit NULL,
		VirtualTourText bit NULL,
		WarrantyText bit NULL,
		TankWarranty bit NULL,
		PartsWarranty bit NULL,
		LaborWarranty bit NULL,
		HeatExchangeWarranty bit NULL,
		compressorWarranty bit NULL,
		ExtendedWarranty bit NULL,
		DisplayOnBHPG bit NULL,
		DRHorton bit NULL,
		GallonCapacity bit NULL,
		TaxCredit bit NULL,
		TaxCreditText bit NULL,
		Gas bit NULL,
		Electric bit NULL,
		Tankless bit NULL,
		Solar bit NULL,
		SortOrder bit NULL,
		PriceRangeDELETE bit NULL,
		ShowInRegistrationDELETE bit NULL,
		ProductSystem bit NULL,
		Common bit NULL,
		AgencyApprovals bit NULL,
		EfficiencyRange bit NULL,
		ContractorFAB bit NULL,
		CreateDateTime__Gen datetime NULL,
		UpdateDateTime__Gen datetime NULL,
	 CONSTRAINT PK_ProductCategories PRIMARY KEY CLUSTERED 
	(
		ProductCategoryID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	exec('Insert Into ProductCategory Select * from Products..ProductCategory')
END



IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductGroup') AND type in (N'U'))
BEGIN
	CREATE TABLE ProductGroup(
		ProductGroupID uniqueidentifier NOT NULL,
		GroupName varchar(256) NULL,
		GroupSpecificationHTML text NULL,
		GroupFeaturesHTML text NULL,
		AC bit NULL,
		WH bit NULL,
		GroupWarrantyHTML text NULL,
		ProductCategoryID uniqueidentifier NULL,
		SequenceNumber int NULL,
		CreateDateTime__Gen datetime NULL,
		UpdateDateTime__Gen datetime NULL,
		BrandID uniqueidentifier NULL,
	 CONSTRAINT PK_ProductGroup PRIMARY KEY CLUSTERED 
	(
		ProductGroupID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	
	ALTER TABLE ProductGroup  WITH CHECK ADD  CONSTRAINT FK_ProductGroup_ProductCategoryID FOREIGN KEY(ProductCategoryID)
	REFERENCES ProductCategory (ProductCategoryID)
	ON DELETE CASCADE

	ALTER TABLE ProductGroup CHECK CONSTRAINT FK_ProductGroup_ProductCategoryID

	
	EXEC('Insert Into ProductGroup Select * from PRODUCTS..ProductGroup')
END



IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductProductGroup') AND type in (N'U'))
BEGIN
	CREATE TABLE ProductProductGroup(
		ProductProductGroupID uniqueidentifier NOT NULL,
		ProductID uniqueidentifier NULL,
		ProductGroupID uniqueidentifier NULL,
		CreateDateTime__Gen datetime NULL,
		UpdateDateTime__Gen datetime NULL,
	 CONSTRAINT PK_ProductProductGroup PRIMARY KEY CLUSTERED 
	(
		ProductProductGroupID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE ProductProductGroup  WITH CHECK ADD  CONSTRAINT FK_ProductProductGroup_ProductID FOREIGN KEY(ProductID)
	REFERENCES Product (ProductID)
	ON DELETE CASCADE

	ALTER TABLE ProductProductGroup CHECK CONSTRAINT FK_ProductProductGroup_ProductID

	ALTER TABLE ProductProductGroup  WITH CHECK ADD  CONSTRAINT FK_ProductProductGroup_ProductGroup FOREIGN KEY(ProductGroupID)
	REFERENCES ProductGroup (ProductGroupID)
	ON DELETE CASCADE

	ALTER TABLE ProductProductGroup CHECK CONSTRAINT FK_ProductProductGroup_ProductGroup
    EXEC('Insert Into ProductProductGroup Select * from PRODUCTS..ProductProductGroup ppg where ppg.ProductID in (Select ProductID from rheemusers..Product) and
  ppg.ProductGroupID in (select ProductGroupID from Products..ProductGroup)')
END


