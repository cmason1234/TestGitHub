USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RatingContractorWaterHeater]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RatingContractorWaterHeater]( 
    [RatingContractorWaterHeaterID] [uniqueidentifier] NOT NULL, 
    [RatingParentID] [uniqueidentifier] NOT NULL, 
    [Installer] [bit] NULL, 
    [Retail] [bit] NULL, 
    [ServiceContractor] [bit] NULL, 
    [Repair] [bit] NULL, 
    [Wholesaler] [bit] NULL, 
    [Commercial] [bit] NULL, 
    [Residential] [bit] NULL, 
    [ManufacturedHome] [bit] NULL, 
    [ServiceWhatWeSell] [bit] NULL, 
    [ServiceCommercialElectric] [bit] NULL, 
    [ServiceCommercialGas] [bit] NULL, 
    [ServiceResidentialElectric] [bit] NULL, 
    [ServiceResidentialGas] [bit] NULL, 
    [ServiceMobileHomeElectric] [bit] NULL, 
    [ServiceMobileHomeGas] [bit] NULL, 
    [ServiceTanklessElectric] [bit] NULL, 
    [ServiceTanklessGas] [bit] NULL, 
    [ServiceSolar] [bit] NULL, 
    [LicensedPlumber] [bit] NULL, 
    [ShowRoom] [bit] NULL, 
    [ShowOnLocator] [bit] NULL, 
    [SellProduct] [bit] NULL, 
    [NewInstallation] [bit] NULL, 
    [ReplacementInstallation] [bit] NULL, 
    [ProClubMember] [bit] NULL, 
    [PrivateLabel] [bit] NULL, 
    [HomeDepot] [bit] NULL, 
    [GE] [bit] NULL, 
    [NoGE] [bit] NULL, 
    [Vanguard] [bit] NULL, 
    [RheemTankless] [bit] NULL, 
    [RuudTankless] [bit] NULL, 
    [RheemTank] [bit] NULL, 
    [RuudTank] [bit] NULL, 
    [Richmond] [bit] NULL, 
    [RichmondTankless] [bit] NULL, 
    [PalomaTankless] [bit] NULL, 
CONSTRAINT [PK_RatingContractorWaterHeater] PRIMARY KEY CLUSTERED 
(
    [RatingContractorWaterHeaterID] ASC
) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[RatingContractorWaterHeater]  WITH CHECK ADD  CONSTRAINT [FK_RatingContractorWaterHeater_RatingParent] FOREIGN KEY([RatingParentID])
REFERENCES [dbo].[RatingParent] ([RatingParentID])
ON DELETE CASCADE

END