USE RheemUsers
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DistributorLocatorProcess') AND type in (N'U'))
BEGIN

	CREATE TABLE DistributorLocatorProcess (
		DistributorLocatorProcessID uniqueidentifier NOT NULL,
		OrganizationID uniqueidentifier NOT NULL,
		StartDate datetime NOT NULL,
		EndDate datetime NULL,
		NotificationDate datetime NULL,
		DSMPersonID uniqueidentifier NOT NULL,
		CreateDateTime__Gen datetime NULL,
		UpdateDateTime__Gen datetime NULL,
	 CONSTRAINT PK_DistributorLocatorProcess PRIMARY KEY CLUSTERED 
	(
		DistributorLocatorProcessID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
	END
	
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DistributorLocatorProcessCoordinator') AND type in (N'U'))
BEGIN

	CREATE TABLE DistributorLocatorProcessCoordinator (
		DistributorLocatorProcessCoordinatorID uniqueidentifier NOT NULL,
		DistributorLocatorProcessID uniqueidentifier NOT NULL,
		POCPersonID uniqueidentifier NOT NULL,
		CreateDateTime__Gen datetime NULL,
		UpdateDateTime__Gen datetime NULL,
	 CONSTRAINT PK_DistributorLocatorProcessCoordinator PRIMARY KEY CLUSTERED 
	(
		DistributorLocatorProcessCoordinatorID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE [dbo].[DistributorLocatorProcessCoordinator]  WITH CHECK ADD  CONSTRAINT [FK_DistributorLocatorProcessCoordinator_DistributorLocatorProcess] FOREIGN KEY([DistributorLocatorProcessID])
	REFERENCES [dbo].[DistributorLocatorProcess] (DistributorLocatorProcessID)

	END	
GO




