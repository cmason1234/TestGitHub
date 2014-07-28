USE RheemUsers
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ProductAC') AND type in (N'U'))
BEGIN

	CREATE TABLE ProductAC(
		ProductACID uniqueidentifier NOT NULL,
		ProductID uniqueIdentifier NOT NULL,
		OutdoorUnitOnly bit NOT NULL,
		OutdoorUnitGas bit NOT NULL, 
		OutdoorUnitAir bit NOT NULL, 
		IndoorUnitOnly bit NOT NULL, 
		PackageUnit bit NOT NULL, 
		OutdoorUnitWithCoil bit NOT NULL,
		CreateDateTime__Gen DateTime,
		UpdateDateTime__Gen DateTime,
	 CONSTRAINT PK_ProductAC PRIMARY KEY CLUSTERED 
	(
		ProductACID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
	
	exec('insert into ProductAC (ProductACID, ProductID, OutdoorUnitOnly, OutdoorUnitGas, OutdoorUnitAir, 
	    IndoorUnitOnly, PackageUnit, OutdoorUnitWithCoil, CreateDateTime__Gen, UpdateDateTime__Gen)
      (Select newid(), ProductID, isNull(OutdoorUnitOnly, 0), isNull(OutdoorUnitGas, 0), isNull(OutdoorUnitAir, 0), 
	      isNull(IndoorUnitOnly, 0), isNull(PackageUnit, 0), isNull(OutdoorUnitWithCoil, 0), sysdatetime(), sysdatetime() from Products..Product)')
END
GO

if NOT exists (SELECT * FROM sys.indexes WHERE name='IDX_ProdAC_ProductID' AND object_id = OBJECT_ID('ProductAC'))
   CREATE UNIQUE NONCLUSTERED INDEX IDX_ProdAC_ProductID ON 
     dbo.ProductAC(ProductID) ON [PRIMARY]
	 
go

if not EXISTS(select * from sys.columns where Name = N'GasEfficiency'  
            and Object_ID = Object_ID(N'ProductAC'))
	ALTER TABLE dbo.ProductAC add  GasEfficiency float not null default 0
GO
