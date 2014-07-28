USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[Product]( 
		[ProductID] [uniqueidentifier] NOT NULL, 
		[Model] [varchar](50) NOT NULL,
		[MetaTitle] [varchar](50) NULL, 
		[MetaDescription] [varchar](512) NULL, 
		[EPSLocationURL] [varchar](256) NULL, 
		[BrandID] [uniqueidentifier] NULL,
		[ProductCategoryID] [uniqueidentifier] NULL,
		[DivisionID] [uniqueidentifier] NULL,
		[Commercial] [bit] NOT NULL,
		[Residential] [bit] NOT NULL,
		[Disabled] [bit] NOT NULL,
		[CountryID] [uniqueidentifier] NOT NULL,
	CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
	( 
		[ProductID] ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 

	INSERT INTO rheemusers..[Product] 
	([ProductID],[Model],[BrandID],[ProductCategoryID],[DivisionID],
	 [Commercial],[Residential],[Disabled],[CountryID]) 
	 SELECT a.[ProductID],a.[Model],[BrandID],[ProductCategoryID],[DivisionID],
	 	    a.[MarketCommercial] AS Commercial,a.[MarketResidential] AS Residential,
	        ISNULL(a.[Historical], 0) AS Disabled,ISNULL(b.[CountryID], '002D9A81-02D6-4165-B896-0BD066934EAB')
	 FROM Products..[Product] a
	      LEFT OUTER JOIN Products..[ProductMaster] b ON a.ProductID=b.ProductID 
END


IF NOT EXISTS (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
    table_name = 'Product' and column_name = 'UseModelPage')
BEGIN
    ALTER TABLE dbo.Product ADD
	UseModelPage bit NOT NULL CONSTRAINT DF_Product_UseModelPage DEFAULT 0
END


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductPageSection]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ProductPageSection]( 
		[ProductPageSectionID] [uniqueidentifier] NOT NULL, 
		[Title] [varchar](50) NULL, 
	CONSTRAINT [PK_ProductPageSection] PRIMARY KEY CLUSTERED 
	( 
		[ProductPageSectionID] ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductPageDetail]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ProductPageDetail]( 
		[ProductPageDetailID] [uniqueidentifier] NOT NULL, 
		[ProductID] [uniqueidentifier] NOT NULL, 
		[ProductPageSectionID] [uniqueidentifier] NOT NULL, 
		[SortOrder] [int] NOT NULL, 
		[ButtonTitle] [varchar](50) NOT NULL, 
		[BodyContent] [text] NOT NULL, 
		[ExternalURL] [varchar](256) NULL, 
		[OnClick] [varchar](512) NULL, 
	CONSTRAINT [PK_ProductPageDetail] PRIMARY KEY CLUSTERED 
	( 
		[ProductPageDetailID] ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY] 

	ALTER TABLE [dbo].[ProductPageDetail]  WITH CHECK ADD  CONSTRAINT [FK_ProductPageDetail_Product] FOREIGN KEY([ProductID]) 
	REFERENCES [dbo].[Product] ([ProductID]) 

	ALTER TABLE [dbo].[ProductPageDetail] CHECK CONSTRAINT [FK_ProductPageDetail_Product] 

	ALTER TABLE [dbo].[ProductPageDetail]  WITH CHECK ADD  CONSTRAINT [FK_ProductPageDetail_ProductPageSection] FOREIGN KEY([ProductPageSectionID]) 
	REFERENCES [dbo].[ProductPageSection] ([ProductPageSectionID]) 

	ALTER TABLE [dbo].[ProductPageDetail] CHECK CONSTRAINT [FK_ProductPageDetail_ProductPageSection] 
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductPageHero]') AND type in (N'U'))
DROP TABLE [dbo].[ProductPageHero]
GO

IF EXISTS (select * from rheemusers.INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME='ButtonTitle' and TABLE_NAME='ProductPageDetail')
ALTER TABLE [dbo].[ProductPageDetail] DROP COLUMN ButtonTitle
GO
IF NOT EXISTS (select * from rheemusers.INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME='Disabled' and TABLE_NAME='ProductPageDetail')
ALTER TABLE [dbo].[ProductPageDetail] ADD Disabled bit NOT NULL default 0
GO
IF NOT EXISTS (select * from rheemusers.INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME='TemplateContent' and TABLE_NAME='ProductPageSection')
ALTER TABLE [dbo].[ProductPageSection] ADD TemplateContent text NULL 
GO
ALTER TABLE [dbo].[ProductPageDetail] ALTER COLUMN BodyContent text NULL
GO

IF NOT EXISTS (select * from rheemusers.INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME='HeroTitle' and TABLE_NAME='Product')
ALTER TABLE [dbo].[Product] ADD HeroTitle varchar(150) NULL
GO
IF NOT EXISTS (select * from rheemusers.INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME='HeroSubTitle' and TABLE_NAME='Product')
ALTER TABLE [dbo].[Product] ADD HeroSubTitle varchar(150) NULL
GO
IF NOT EXISTS (select * from rheemusers.INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME='ProductInformation' and TABLE_NAME='Product')
ALTER TABLE [dbo].[Product] ADD ProductInformation text NULL
GO
IF EXISTS (select * from rheemusers.INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME='EPSLocationURL' and TABLE_NAME='Product')
ALTER TABLE [dbo].[Product] DROP COLUMN EPSLocationURL
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductLiterature]') AND type in (N'U'))
	BEGIN
		CREATE TABLE [dbo].[ProductLiterature](
			[ProductLiteratureID] [uniqueidentifier] NOT NULL,
			[ProductID] [uniqueidentifier] NULL,
			[BriefDescription] [text] NULL,
			[Disabled] [bit] NOT NULL,
			[SeqNumber] [int] NULL,
			[CreateDateTime__Gen] [datetime] NULL,
			[UpdateDateTime__Gen] [datetime] NULL,
		 CONSTRAINT [PK_ProductLiterature] PRIMARY KEY CLUSTERED 
		(
			[ProductLiteratureID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

	ALTER TABLE [dbo].[ProductLiterature] ADD CONSTRAINT FK_ProductLiterature_ProductID FOREIGN KEY (ProductID) REFERENCES [dbo].[Product](ProductID) ON DELETE CASCADE

	INSERT INTO rheemusers..[ProductLiterature] 
	([ProductLiteratureID],[ProductID],[BriefDescription],[Disabled],[SeqNumber],
	 [CreateDateTime__Gen],[UpdateDateTime__Gen]) 
	 SELECT [ProductLiteratureID],[ProductID],[BriefDescription],CASE WHEN AvailableForLiterature=1 THEN 0 ELSE 1 END As Disabled,[SeqNumber],
	 	    [CreateDateTime__Gen],[UpdateDateTime__Gen]
	 FROM Products..[ProductLiterature] WHERE ProductID in (SELECT ProductID FROM rheemusers..Product)

	END

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductLiteratureDescription]') AND type in (N'U'))
	BEGIN
		CREATE TABLE [dbo].[ProductLiteratureDescription](
			[ProductLiteratureDescriptionID] [uniqueidentifier] NOT NULL,
			[ProductID] [uniqueidentifier] NULL,
			[SeqNumber] [int] NULL,
			[Description] [varchar](1024) NULL,
			[BriefDescription] [bit] NOT NULL,
			[WarrantyDescription] [bit] NOT NULL,
			[FullDescription] [bit] NOT NULL,
			[CreateDateTime__Gen] [datetime] NULL,
			[UpdateDateTime__Gen] [datetime] NULL,
		 CONSTRAINT [PK_ProductLiteratureDescription] PRIMARY KEY CLUSTERED 
		(
			[ProductLiteratureDescriptionID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

	ALTER TABLE [dbo].[ProductLiteratureDescription] ADD CONSTRAINT FK_ProductLiteratureDescription_ProductID FOREIGN KEY (ProductID) REFERENCES [dbo].[Product](ProductID) ON DELETE CASCADE

	INSERT INTO rheemusers..[ProductLiteratureDescription] 
	([ProductLiteratureDescriptionID],[ProductID],[SeqNumber],[Description],[BriefDescription],[WarrantyDescription],[FullDescription],
	 [CreateDateTime__Gen],[UpdateDateTime__Gen]) 
	 SELECT [ProductLiteratureDescriptionID],[ProductID],[SeqNumber],[Description],ISNULL([BriefDescription], 0),ISNULL([WarrantyDescription], 0),ISNULL([FullDescription], 0),
	 	    [CreateDateTime__Gen],[UpdateDateTime__Gen]
	 FROM Products..[ProductLiteratureDescription] WHERE ProductID in (SELECT ProductID FROM rheemusers..Product)

	END

GO

if NOT EXISTS(select * from sys.columns where Name = N'AvailableForLiterature'  
            and Object_ID = Object_ID(N'Product'))
 BEGIN
  ALTER TABLE Product ADD AvailableForLiterature bit
  
  exec('UPDATE Product set Product.AvailableForLiterature=pm.AvailableForLiterature
      FROM Product p
	    INNER JOIN Products..ProductMaster pm on p.ProductID=pm.ProductID')

  exec('UPDATE Product set AvailableForLiterature=0 where AvailableForLiterature is NULL')

  exec('ALTER TABLE Product Alter Column AvailableForLiterature bit NOT NULL')
 END
GO

if NOT EXISTS(select * from sys.columns where Name = N'ProductLiteratureDirty'  
            and Object_ID = Object_ID(N'Product'))
 BEGIN
  ALTER TABLE Product ADD ProductLiteratureDirty bit Not Null Default 0
 END
GO

if NOT EXISTS(select * from sys.columns where Name = N'InternationalBit'  
            and Object_ID = Object_ID(N'Product'))
 BEGIN
  ALTER TABLE Product ADD InternationalBit bit Not Null Default 0
 END
GO



IF OBJECTPROPERTY(OBJECT_ID('ProductLiterature_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ProductLiterature_Trigger
END
GO

CREATE TRIGGER ProductLiterature_Trigger
	   ON  ProductLiterature
	   AFTER INSERT, UPDATE, DELETE
	AS 
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
		
		IF EXISTS(SELECT * FROM inserted)
		BEGIN
		  IF EXISTS(SELECT * FROM deleted)
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ProductLiterature', 'RheemUsers', ProductLiteratureID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ProductLiterature', 'RheemUsers', ProductLiteratureID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ProductLiterature', 'RheemUsers', ProductLiteratureID from deleted
		END;
	END
GO


IF OBJECTPROPERTY(OBJECT_ID('ProductLiteratureDescription_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ProductLiteratureDescription_Trigger
END
GO

CREATE TRIGGER ProductLiteratureDescription_Trigger
	   ON  ProductLiteratureDescription
	   AFTER INSERT, UPDATE, DELETE
	AS 
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
		
		IF EXISTS(SELECT * FROM inserted)
		BEGIN
		  IF EXISTS(SELECT * FROM deleted)
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ProductLiteratureDescription', 'RheemUsers', ProductLiteratureDescriptionID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ProductLiteratureDescription', 'RheemUsers', ProductLiteratureDescriptionID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ProductLiteratureDescription', 'RheemUsers', ProductLiteratureDescriptionID from deleted
		END;
	END
GO




