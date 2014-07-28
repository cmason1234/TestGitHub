USE RheemUsers
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Parts_Model') AND type in (N'U'))
BEGIN

	CREATE TABLE Parts_Model(
		Parts_ModelID int NOT NULL,
		Model varchar(50) NOT NULL,
		ModelDescription varchar(100) NOT NULL,
		Brand varchar(50) NOT NULL,
		CONSTRAINT PK_Parts_Model PRIMARY KEY CLUSTERED 
		(
			Parts_ModelID ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'Parts_Model_idx1' AND object_id = OBJECT_ID('Parts_Model'))
BEGIN
   CREATE NONCLUSTERED INDEX Parts_Model_idx1 ON Parts_Model (Model)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Parts_Component') AND type in (N'U'))
BEGIN

	CREATE TABLE Parts_Component(
		Parts_ComponentID int NOT NULL,
		ComponentNumber varchar(50) NOT NULL,
		UPCNumber varchar(50) Not Null,
		ComponentDescription varchar(300) NOT NULL,
		ComponentLength float,
		ComponentWidth float,
		ComponentHeight float,
		ComponentWeight float,
		Replacement varchar(50),
		CONSTRAINT PK_Parts_Component PRIMARY KEY CLUSTERED 
		(
			Parts_ComponentID ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
END
GO
IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'Parts_Component_idx1' AND object_id = OBJECT_ID('Parts_Component'))
BEGIN
   CREATE NONCLUSTERED INDEX Parts_Component_idx1 ON Parts_Component (ComponentNumber)
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'Parts_ModelComponent') AND type in (N'U'))
BEGIN

	CREATE TABLE Parts_ModelComponent(
		Parts_ModelComponentID int NOT NULL,
		Parts_ModelID int NOT NULL CONSTRAINT FK_ModelComponent_1 FOREIGN KEY REFERENCES Parts_Model(Parts_ModelID) ON DELETE CASCADE,
		Parts_ComponentID int NOT NULL CONSTRAINT FK_ModelComponent_2 FOREIGN KEY REFERENCES Parts_Component(Parts_ComponentID) ON DELETE CASCADE,
		Usage_Count float NOT NULL,
		CONSTRAINT PK_Parts_ModelComponent PRIMARY KEY CLUSTERED 
		(
			Parts_ModelComponentID ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
END
GO


