USE [RheemUsers]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HDAgreement') AND type in (N'U'))
BEGIN

	/****** Object:  Table [dbo].[HDAgreement]    Script Date: 09/20/2012 09:58:51 ******/

	CREATE TABLE [dbo].[HDAgreement](
		[HDAgreementID] [int] IDENTITY(1,1)  NOT NULL,
		[PersonID] [uniqueidentifier] NOT NULL,
		[OrganizationID] [uniqueidentifier] NOT NULL,
		[InstallationProfessional] [varchar](350) NOT NULL,
		[License] [varchar](50) NULL,
		[LicenseExpiration] [datetime] NULL,
		[ProposalDate] [datetime] NULL,
		[Address] [varchar](250) NULL,
		[City] [varchar](50) NULL,
		[State] [varchar](2) NULL,
		[PostalCode] [varchar](50) NULL,
		[Phone] [varchar](50) NULL,
		[LeadNumber] [int] NULL,
		[StoreNumber] [int] NULL,
		[InstallerNumber] [int] NULL,
		[CustomerFirst] [varchar](50) NULL,
		[CustomerLast] [varchar](50) NULL,
		[ServiceAddress] [varchar](250) NULL,
		[ServiceCity] [varchar](50) NULL,
		[ServiceState] [varchar](2) NULL,
		[ServicePostalCode] [varchar](50) NULL,
		[CustomerPhoneDay] [varchar](50) NULL,
		[CustomerPhoneEvening] [varchar](50) NULL,
		[CustomerEmail] [varchar](50) NULL,
		[ESANoDeductible] [bit] NOT NULL,
		[ESADeductible] [bit] NOT NULL,
		[ESAManufacturer] [bit] NOT NULL,
		[ESAManufacturerText] [varchar](50) NULL,
		[ESALength5] [bit] NOT NULL,
		[ESALength10] [bit] NOT NULL,
		[ESALength12] [bit] NOT NULL,
		[ESALengthOther] [bit] NOT NULL,
		[ESALengthOtherText] [varchar](50) NULL,
		[ESAParts] [bit] NOT NULL,
		[ESALabor] [bit] NOT NULL,
		[ESAPartsAndLabor] [bit] NOT NULL,
		[ESACompleteSystem] [bit] NOT NULL,
		[ESACondensing] [bit] NOT NULL,
		[ESAFurnaceAirHandler] [bit] NOT NULL,
		[ESAAccessory] [bit] NOT NULL,
		[ESABoiler] [bit] NOT NULL,
		[ESAOther] [bit] NOT NULL,
		[ESAOtherText] [varchar](50) NULL,
		[OutdoorNewPad] [bit] NOT NULL,
		[OutdoorUseExistingPad] [bit] NOT NULL,
		[DuctProperlySized] [bit] NOT NULL,
		[DuctReconnectExisting] [bit] NOT NULL,
		[DuctModificationNeeded] [bit] NOT NULL,

		[IndoorCondenstateReconnect] [bit] NOT NULL,
		[IndoorCondenstateReconnectPump] [bit] NOT NULL,
		[IndoorCondenstateReconnectLine] [bit] NOT NULL,
		[IndoorCondenstateReconnectDrain] [bit] NOT NULL,
		[IndoorCondenstateReconnectPan] [bit] NOT NULL,
		
		[IndoorCondensateNew] [bit] NOT NULL,
		[IndoorCondensateNewPump] [bit] NOT NULL,
		[IndoorCondensateNewLine] [bit] NOT NULL,
		[IndoorCondensateNewDrain] [bit] NOT NULL,
		[IndoorCondensateNewPan] [bit] NOT NULL,				
		
		[IndoorFlueReconnect] [bit] NOT NULL,
		
		[IndoorFlueNewFoundation] [bit] NOT NULL,
		[IndoorFlueNewRoof] [bit] NOT NULL,
		[IndoorFlueNewWall] [bit] NOT NULL,
		[IndoorFlueNewChimney] [bit] NOT NULL,
		
		[IndoorGasFuelLineReconnect] [bit] NOT NULL,
		[IndoorGasFuelLineNew] [bit] NOT NULL,
		[RefrigInstall] [bit] NOT NULL,
		[RefrigReconnect] [bit] NOT NULL,
		[ComfortInstall] [bit] NOT NULL,
		[ComfortReconnect] [bit] NOT NULL,
		[RemoveOldEquipment] [bit] NOT NULL,
		[RemoveOldDuctwork] [bit] NOT NULL,
		[ElectricalReconnectIndoor] [bit] NOT NULL,
		[ElectricalReconnectOutdoor] [bit] NOT NULL,
		[ElectricalNewIndoor] [bit] NOT NULL,
		[ElectricalNewOutdoor] [bit] NOT NULL,
		[ElectricalUpgrade] [bit] NOT NULL,
		[Electrical] [bit] NOT NULL,
		[ReuseFurnace] [bit] NOT NULL,
		[ReuseAC] [bit] NOT NULL,
		[ReuseHP] [bit] NOT NULL,
		[ReuseCoil] [bit] NOT NULL,
		[ReuseAH] [bit] NOT NULL,
		[Notes] [text] NULL,
		[Status] [varchar](8) NOT NULL,
 	    [CreateDateTime__Gen] [datetime] NOT NULL,
	    [UpdateDateTime__Gen] [datetime] NOT NULL,
	 CONSTRAINT [PK_HDAgreement] PRIMARY KEY CLUSTERED 
	(
		[HDAgreementID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HDAgreementOption') AND type in (N'U'))
BEGIN

	CREATE TABLE [dbo].[HDAgreementOption](
		[HDAgreementOptionID] [int] IDENTITY(1,1) NOT NULL,
		[HDAgreementID] [int] NULL,
		[OptionNumber] [int] NULL,
		[HeatingLoadCalculation] [varchar](50) NULL,
		[CoolingLoadCalculation] [varchar](50) NULL,
		[Sensible] [varchar](50) NULL,
		[Latent] [varchar](50) NULL,
		[CondenserHeatPumpMFG] [varchar](250) NULL,
		[CondenserHeatPumpModel] [varchar](250) NULL,
		[CondenserHeatPumpWarranty] [varchar](250) NULL,
		[AirHandlerFurnaceMFG] [varchar](250) NULL,
		[AirHandlerFurnaceModel] [varchar](250) NULL,
		[AirHandlerFurnaceWarranty] [varchar](250) NULL,
		[StripHeatCoilMFG] [varchar](250) NULL,
		[StripHeatCoilModel] [varchar](250) NULL,
		[StripHeatCoilWarranty] [varchar](250) NULL,
		[ThermostatMFG] [varchar](250) NULL,
		[ThermostatModel] [varchar](250) NULL,
		[ThermostatWarranty] [varchar](250) NULL,
		[Other1MFG] [varchar](250) NULL,
		[Other1Model] [varchar](250) NULL,
		[Other1Warranty] [varchar](250) NULL,
		[Other2MFG] [varchar](250) NULL,
		[Other2Model] [varchar](250) NULL,
		[Other2Warranty] [varchar](250) NULL,
		[Notes] [text] NULL,
		[EquiptmentAndLabor] [float] NULL,
		[Discounts] [float] NULL,
		[DiscountText] [varchar](250) NULL,
		[SalesTax] [float] NULL,
		[OptionTotal] [float] NULL,
		[IsContractOption] [bit] NOT NULL,
 	    [CreateDateTime__Gen] [datetime] NOT NULL,
	    [UpdateDateTime__Gen] [datetime] NOT NULL,
	 CONSTRAINT [PK_HDAgreementOption] PRIMARY KEY CLUSTERED 
	(
		[HDAgreementOptionID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	ALTER TABLE [dbo].[HDAgreementOption]  WITH CHECK ADD  CONSTRAINT [FK_HDAgreementOption_HDAgreement] FOREIGN KEY([HDAgreementID])
	REFERENCES [dbo].[HDAgreement] ([HDAgreementID]) ON DELETE CASCADE

END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HDAgreementEmail') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[HDAgreementEmail](
	[HDAgreementEmailID] [int] IDENTITY(1,1) NOT NULL,
	[HDAgreementID] [int] NOT NULL,
	[EmailTo] [varchar](150) NULL,
	[EmailStatus] [varchar](50) NULL,
	[StatusError] [varchar](500) NULL,
	[EmailDate] [smalldatetime] NULL,
	[CreateDateTime__Gen] [datetime] NOT NULL,
	[UpdateDateTime__Gen] [datetime] NOT NULL,
 CONSTRAINT [PK_HDAgreementEmail] PRIMARY KEY CLUSTERED 
(
	[HDAgreementEmailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

	ALTER TABLE [dbo].[HDAgreementEmail]  WITH CHECK ADD  CONSTRAINT [FK_HDAgreementEmail_HDAgreement] FOREIGN KEY([HDAgreementID])
	REFERENCES [dbo].[HDAgreement] ([HDAgreementID]) ON DELETE CASCADE

END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HDAgreementLog') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[HDAgreementLog](
	[HDAgreementLogID] [int] IDENTITY(1,1) NOT NULL,
	[HDAgreementID] [int] NOT NULL,
	[PersonID] [uniqueidentifier] NOT NULL,
	[LogTimeStamp] [datetime] NOT NULL,
	[LogText] [varchar](1000) NOT NULL,
	[CreateDateTime__Gen] [datetime] NOT NULL,
	[UpdateDateTime__Gen] [datetime] NOT NULL,
 CONSTRAINT [PK_HDAgreementLog] PRIMARY KEY CLUSTERED 
(
	[HDAgreementLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

	ALTER TABLE [dbo].[HDAgreementLog]  WITH CHECK ADD  CONSTRAINT [FK_HDAgreementLog_HDAgreement] FOREIGN KEY([HDAgreementID])
	REFERENCES [dbo].[HDAgreement] ([HDAgreementID]) ON DELETE CASCADE

END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'HDAgreementNote') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[HDAgreementNote](
	[HDAgreementNoteID] [int] IDENTITY(1,1) NOT NULL,
	[HDAgreementID] [int] NOT NULL,
	[NoteTimeStamp] [datetime] NOT NULL,
	[PersonID] [uniqueidentifier] NOT NULL,
	[NoteText] [varchar](1000) NOT NULL,
	[CreateDateTime__Gen] [datetime] NOT NULL,
	[UpdateDateTime__Gen] [datetime] NOT NULL,
 CONSTRAINT [PK_HDAgreementNote] PRIMARY KEY CLUSTERED 
(
	[HDAgreementNoteID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

	ALTER TABLE [dbo].[HDAgreementNote]  WITH CHECK ADD  CONSTRAINT [FK_HDAgreementNote_HDAgreement] FOREIGN KEY([HDAgreementID])
	REFERENCES [dbo].[HDAgreement] ([HDAgreementID]) ON DELETE CASCADE

END


if NOT EXISTS(select * from sys.columns where Name = N'SignatureDrawingPoints'  
            and Object_ID = Object_ID(N'HDAgreement'))
ALTER TABLE [dbo].[HDAgreement] ADD [SignatureDrawingPoints] [text] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'CoSignSignatureDrawingPoints'  
            and Object_ID = Object_ID(N'HDAgreement'))
ALTER TABLE [dbo].[HDAgreement] ADD [CoSignSignatureDrawingPoints] [text] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'EmailConsent'  
            and Object_ID = Object_ID(N'HDAgreement'))
ALTER TABLE [dbo].[HDAgreement] ADD [EmailConsent] [bit] NOT NULL Default 0
GO

if NOT EXISTS(select * from sys.columns where Name = N'EmailConfirm'  
            and Object_ID = Object_ID(N'HDAgreement'))
ALTER TABLE [dbo].[HDAgreement] ADD [EmailConfirm] [bit] NOT NULL Default 0
GO

if NOT EXISTS(select * from sys.columns where Name = N'Initials'  
            and Object_ID = Object_ID(N'HDAgreement'))
ALTER TABLE [dbo].[HDAgreement] ADD [Initials] [varchar](10) Null
GO

if NOT EXISTS(select * from sys.columns where Name = N'InitialsConsent'  
            and Object_ID = Object_ID(N'HDAgreement'))
ALTER TABLE [dbo].[HDAgreement] ADD [InitialsConsent] [text] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'InitialsCancellation'  
            and Object_ID = Object_ID(N'HDAgreement'))
ALTER TABLE [dbo].[HDAgreement] ADD [InitialsCancellation] [text] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'InitialsTermination'  
            and Object_ID = Object_ID(N'HDAgreement'))
ALTER TABLE [dbo].[HDAgreement] ADD [InitialsTermination] [text] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'CloudURLSeed'  
            and Object_ID = Object_ID(N'HDAgreement'))
ALTER TABLE [dbo].[HDAgreement] ADD [CloudURLSeed] [uniqueidentifier] NULL
GO
