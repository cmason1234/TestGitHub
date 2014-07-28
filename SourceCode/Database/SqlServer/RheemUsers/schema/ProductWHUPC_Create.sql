USE [RheemUsers]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductWHBaseModel]') AND type in (N'U'))
BEGIN
	SELECT * INTO ProductWHBaseModel from Products..BaseModel
	exec sp_Rename 'ProductWHBaseModel.BaseModelID', 'ProductWHBaseModelID', 'COLUMN'
	ALTER TABLE ProductWHBaseModel WITH NOCHECK 
	  ADD CONSTRAINT [PK_ProductWHBaseModel] PRIMARY KEY CLUSTERED ([ProductWHBaseModelID] ASC)
	  WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY];

    USE [Products]
	exec sp_rename 'BaseModel', 'DeleteMe_BaseModel'
END

USE [RheemUsers]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductWHBTU]') AND type in (N'U'))
BEGIN
	SELECT * INTO ProductWHBTU from Products..BTU
	exec sp_Rename 'ProductWHBTU.BTUID', 'ProductWHBTUID', 'COLUMN'
	ALTER TABLE ProductWHBTU WITH NOCHECK 
	  ADD CONSTRAINT [PK_ProductWHBTU] PRIMARY KEY CLUSTERED ([ProductWHBTUID] ASC)
	  WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY];

    USE [Products]
	exec sp_rename 'BTU', 'DeleteMe_BTU'
END


USE [RheemUsers]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductWHGallonCapacity]') AND type in (N'U'))
BEGIN
	SELECT * INTO ProductWHGallonCapacity from Products..GallonCapacity
	exec sp_Rename 'ProductWHGallonCapacity.GallonCapacityID', 'ProductWHGallonCapacityID', 'COLUMN'
	ALTER TABLE ProductWHGallonCapacity WITH NOCHECK 
	  ADD CONSTRAINT [PK_ProductWHGallonCapacity] PRIMARY KEY CLUSTERED ([ProductWHGallonCapacityID] ASC)
	  WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY];	

    USE [Products]
	exec sp_rename 'GallonCapacity', 'DeleteMe_GallonCapacity'
END

USE [RheemUsers]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductWHPhase]') AND type in (N'U'))
BEGIN
	SELECT * INTO ProductWHPhase from Products..Phase
	exec sp_Rename 'ProductWHPhase.PhaseID', 'ProductWHPhaseID', 'COLUMN'
	ALTER TABLE ProductWHPhase WITH NOCHECK 
	  ADD CONSTRAINT [PK_ProductWHPhase] PRIMARY KEY CLUSTERED ([ProductWHPhaseID] ASC)
	  WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY];	

	USE [Products]
	exec sp_rename 'Phase', 'DeleteMe_Phase'
END


USE [RheemUsers]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductWHWatt]') AND type in (N'U'))
BEGIN
	SELECT * INTO ProductWHWatt from Products..Watt
	exec sp_Rename 'ProductWHWatt.WattID', 'ProductWHWattID', 'COLUMN'
	ALTER TABLE ProductWHWatt WITH NOCHECK 
	  ADD CONSTRAINT [PK_ProductWHWatt] PRIMARY KEY CLUSTERED ([ProductWHWattID] ASC)
	  WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY];	

	USE [Products]
	exec sp_rename 'Watt', 'DeleteMe_Watt'
END

USE [RheemUsers]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductWHVoltage]') AND type in (N'U'))
BEGIN
	SELECT * INTO ProductWHVoltage from Products..Voltage
	exec sp_Rename 'ProductWHVoltage.VoltageID', 'ProductWHVoltageID', 'COLUMN'
	ALTER TABLE ProductWHVoltage WITH NOCHECK 
	  ADD CONSTRAINT [PK_ProductWHVoltage] PRIMARY KEY CLUSTERED ([ProductWHVoltageID] ASC)
	  WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY];	

	USE [Products]
	exec sp_rename 'Voltage', 'DeleteMe_Voltage'
END

USE [RheemUsers]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductWHUPC]') AND type in (N'U'))
BEGIN
	SELECT * INTO ProductWHUPC from Products..WH
	exec sp_Rename 'ProductWHUPC.WHID', 'ProductWHUPCID', 'COLUMN'
	exec sp_Rename 'ProductWHUPC.BaseModelID', 'ProductWHBaseModelID', 'COLUMN'
	exec sp_Rename 'ProductWHUPC.GallonCapacityID', 'ProductWHGallonCapacityID', 'COLUMN'
	exec sp_Rename 'ProductWHUPC.Watt1ID', 'ProductWHWatt1ID', 'COLUMN'
	exec sp_Rename 'ProductWHUPC.Watt2ID', 'ProductWHWatt2ID', 'COLUMN'
	exec sp_Rename 'ProductWHUPC.VoltageID', 'ProductWHVoltageID', 'COLUMN'
	exec sp_Rename 'ProductWHUPC.BTUID', 'ProductWHBTUID', 'COLUMN'
	exec sp_Rename 'ProductWHUPC.PhaseID', 'ProductWHPhaseID', 'COLUMN'
	ALTER TABLE ProductWHUPC WITH NOCHECK 
	  ADD CONSTRAINT [PK_ProductWHUPC] PRIMARY KEY CLUSTERED ([ProductWHUPCID] ASC)
	  WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY];	

	ALTER TABLE ProductWHUPC ADD CONSTRAINT FK_ProdWHUPC_BaseModel FOREIGN KEY (ProductWHBaseModelID)
        REFERENCES ProductWHBaseModel (ProductWHBaseModelID) ;
	ALTER TABLE ProductWHUPC ADD CONSTRAINT FK_ProdWHUPC_GallonCapacity FOREIGN KEY (ProductWHGallonCapacityID)
        REFERENCES ProductWHGallonCapacity (ProductWHGallonCapacityID) ;
	ALTER TABLE ProductWHUPC ADD CONSTRAINT FK_ProdWHUPC_Watt1 FOREIGN KEY (ProductWHWatt1ID)
        REFERENCES ProductWHWatt (ProductWHWattID) ;
	ALTER TABLE ProductWHUPC ADD CONSTRAINT FK_ProdWHUPC_Watt2 FOREIGN KEY (ProductWHWatt2ID)
        REFERENCES ProductWHWatt (ProductWHWattID) ;
	ALTER TABLE ProductWHUPC ADD CONSTRAINT FK_ProdWHUPC_Voltage FOREIGN KEY (ProductWHVoltageID)
        REFERENCES ProductWHVoltage (ProductWHVoltageID) ;
	ALTER TABLE ProductWHUPC ADD CONSTRAINT FK_ProdWHUPC_BTU FOREIGN KEY (ProductWHBTUID)
        REFERENCES ProductWHBTU (ProductWHBTUID) ;
	ALTER TABLE ProductWHUPC ADD CONSTRAINT FK_ProdWHUPC_Phase FOREIGN KEY (ProductWHPhaseID)
        REFERENCES ProductWHPhase (ProductWHPhaseID) ;
--	ALTER TABLE ProductWHUPC ADD CONSTRAINT FK_ProdWHUPC_ListPrice FOREIGN KEY (ListPriceID)
--        REFERENCES ProductWHListPrice (ProductWHListPriceID) ;
	
	USE [Products]
	exec sp_rename 'WH', 'DeleteMe_WH'
END
GO


