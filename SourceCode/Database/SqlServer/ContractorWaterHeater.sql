


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContractorWaterHeater'
   
   AUTHOR:       Mike Harvey - 11/1/2010 9:06:04 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorWaterHeater') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContractorWaterHeater;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContractorWaterHeater
   
   Description:  Inserts a record into table 'ContractorWaterHeater'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContractorWaterHeater
(
	@ContractorWaterHeaterID uniqueidentifier = null output,
	@OrganizationID uniqueidentifier, 
	@WHNumber varchar(50) = null, 
	@VendorNumber varchar(50) = null, 
	@Disabled bit, 
	@Installer bit, 
	@Retail bit, 
	@ServiceContractor bit, 
	@Repair bit, 
	@Wholesaler bit, 
	@StateLicense varchar(50) = null, 
	@NumberOfInstallers int, 
	@ResaleCertificate varchar(50) = null, 
	@Commercial bit, 
	@Residential bit, 
	@Tankless bit, 
	@ManufacturedHome bit, 
	@ServiceWhatWeSell bit, 
	@ServiceCommercialElectric bit, 
	@ServiceCommercialGas bit, 
	@ServiceResidentialElectric bit, 
	@ServiceResidentialGas bit, 
	@ServiceMobileHomeElectric bit, 
	@ServiceMobileHomeGas bit, 
	@ServiceTanklessElectric bit, 
	@ServiceTanklessGas bit, 
	@ServiceSolar bit, 
	@TwentyFourHourServiceMF bit, 
	@TwentyFourHourServiceSat bit, 
	@TwentyFourHourServiceSun bit, 
	@LicensedPlumber bit, 
	@ShowRoom bit, 
	@ShowOnLocator bit, 
	@SellProduct bit, 
	@NewInstallation bit, 
	@ReplacementInstallation bit, 
	@ContractDate datetime, 
	@ContractExpiration datetime, 
	@LicenseExpiration datetime, 
	@InsuranceExpiration datetime, 
	@BusinessExpiration datetime, 
	@PlumbingExpiration datetime, 
	@ResaleExpiration datetime, 
	@ProClubMember bit, 
	@ProClubActive bit, 
	@ProClubNumber int, 
	@PastPro varchar(50) = null, 
	@FileDate datetime, 
	@Rating int, 
	@Rheem bit, 
	@Ruud bit, 
	@Richmond bit, 
	@PrivateLabel bit, 
	@HomeDepot bit, 
	@GE bit, 
	@NoGE bit, 
	@Vanguard bit, 
	@RheemTankless bit, 
	@RuudTankless bit, 
	@RheemTank bit, 
	@RuudTank bit, 
	@RichmondTankless bit, 
	@PalomaTankless bit, 
	@LocatorPlacement int, 
	@DistributorOrganizationID uniqueidentifier, 
	@NoAddressOnConsumer bit
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @ContractorWaterHeaterID = NewID()
	

	INSERT
	INTO [ContractorWaterHeater]
	(
		[ContractorWaterHeaterID], 
		[OrganizationID], 
		[WHNumber], 
		[VendorNumber], 
		[Disabled], 
		[Installer], 
		[Retail], 
		[ServiceContractor], 
		[Repair], 
		[Wholesaler], 
		[StateLicense], 
		[NumberOfInstallers], 
		[ResaleCertificate], 
		[Commercial], 
		[Residential], 
		[Tankless], 
		[ManufacturedHome], 
		[ServiceWhatWeSell], 
		[ServiceCommercialElectric], 
		[ServiceCommercialGas], 
		[ServiceResidentialElectric], 
		[ServiceResidentialGas], 
		[ServiceMobileHomeElectric], 
		[ServiceMobileHomeGas], 
		[ServiceTanklessElectric], 
		[ServiceTanklessGas], 
		[ServiceSolar], 
		[TwentyFourHourServiceMF], 
		[TwentyFourHourServiceSat], 
		[TwentyFourHourServiceSun], 
		[LicensedPlumber], 
		[ShowRoom], 
		[ShowOnLocator], 
		[SellProduct], 
		[NewInstallation], 
		[ReplacementInstallation], 
		[ContractDate], 
		[ContractExpiration], 
		[LicenseExpiration], 
		[InsuranceExpiration], 
		[BusinessExpiration], 
		[PlumbingExpiration], 
		[ResaleExpiration], 
		[ProClubMember], 
		[ProClubActive], 
		[ProClubNumber], 
		[PastPro], 
		[FileDate], 
		[Rating], 
		[Rheem], 
		[Ruud], 
		[Richmond], 
		[PrivateLabel], 
		[HomeDepot], 
		[GE], 
		[NoGE], 
		[Vanguard], 
		[RheemTankless], 
		[RuudTankless], 
		[RheemTank], 
		[RuudTank], 
		[RichmondTankless], 
		[PalomaTankless], 
		[LocatorPlacement], 
		[DistributorOrganizationID], 
		[NoAddressOnConsumer]
	)
	VALUES
	(
		@ContractorWaterHeaterID, 
		@OrganizationID, 
		@WHNumber, 
		@VendorNumber, 
		@Disabled, 
		@Installer, 
		@Retail, 
		@ServiceContractor, 
		@Repair, 
		@Wholesaler, 
		@StateLicense, 
		@NumberOfInstallers, 
		@ResaleCertificate, 
		@Commercial, 
		@Residential, 
		@Tankless, 
		@ManufacturedHome, 
		@ServiceWhatWeSell, 
		@ServiceCommercialElectric, 
		@ServiceCommercialGas, 
		@ServiceResidentialElectric, 
		@ServiceResidentialGas, 
		@ServiceMobileHomeElectric, 
		@ServiceMobileHomeGas, 
		@ServiceTanklessElectric, 
		@ServiceTanklessGas, 
		@ServiceSolar, 
		@TwentyFourHourServiceMF, 
		@TwentyFourHourServiceSat, 
		@TwentyFourHourServiceSun, 
		@LicensedPlumber, 
		@ShowRoom, 
		@ShowOnLocator, 
		@SellProduct, 
		@NewInstallation, 
		@ReplacementInstallation, 
		@ContractDate, 
		@ContractExpiration, 
		@LicenseExpiration, 
		@InsuranceExpiration, 
		@BusinessExpiration, 
		@PlumbingExpiration, 
		@ResaleExpiration, 
		@ProClubMember, 
		@ProClubActive, 
		@ProClubNumber, 
		@PastPro, 
		@FileDate, 
		@Rating, 
		@Rheem, 
		@Ruud, 
		@Richmond, 
		@PrivateLabel, 
		@HomeDepot, 
		@GE, 
		@NoGE, 
		@Vanguard, 
		@RheemTankless, 
		@RuudTankless, 
		@RheemTank, 
		@RuudTank, 
		@RichmondTankless, 
		@PalomaTankless, 
		@LocatorPlacement, 
		@DistributorOrganizationID, 
		@NoAddressOnConsumer

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContractorWaterHeater Succeeded'
Else PRINT 'Procedure Creation: InsertContractorWaterHeater Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorWaterHeaterByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContractorWaterHeaterByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContractorWaterHeaterByID
   
   Description:  Selects record(s) from table 'ContractorWaterHeater'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContractorWaterHeaterByID
(
	@ContractorWaterHeaterID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[ContractorWaterHeaterID], [OrganizationID], [WHNumber], [VendorNumber], [Disabled], [Installer], [Retail], [ServiceContractor], [Repair], [Wholesaler], [StateLicense], [NumberOfInstallers], [ResaleCertificate], [Commercial], [Residential], [Tankless], [ManufacturedHome], [ServiceWhatWeSell], [ServiceCommercialElectric], [ServiceCommercialGas], [ServiceResidentialElectric], [ServiceResidentialGas], [ServiceMobileHomeElectric], [ServiceMobileHomeGas], [ServiceTanklessElectric], [ServiceTanklessGas], [ServiceSolar], [TwentyFourHourServiceMF], [TwentyFourHourServiceSat], [TwentyFourHourServiceSun], [LicensedPlumber], [ShowRoom], [ShowOnLocator], [SellProduct], [NewInstallation], [ReplacementInstallation], [ContractDate], [ContractExpiration], [LicenseExpiration], [InsuranceExpiration], [BusinessExpiration], [PlumbingExpiration], [ResaleExpiration], [ProClubMember], [ProClubActive], [ProClubNumber], [PastPro], [FileDate], [Rating], [Rheem], [Ruud], [Richmond], [PrivateLabel], [HomeDepot], [GE], [NoGE], [Vanguard], [RheemTankless], [RuudTankless], [RheemTank], [RuudTank], [RichmondTankless], [PalomaTankless], [LocatorPlacement], [DistributorOrganizationID], [NoAddressOnConsumer]
	FROM [ContractorWaterHeater]
	WHERE [ContractorWaterHeaterID] = @ContractorWaterHeaterID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContractorWaterHeaterByID Succeeded'
Else PRINT 'Procedure Creation: GetContractorWaterHeaterByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorWaterHeaterByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContractorWaterHeaterByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContractorWaterHeaterByString
   
   Description:  Selects a record from table 'ContractorWaterHeater'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContractorWaterHeaterByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[ContractorWaterHeaterID], [OrganizationID], [WHNumber], [VendorNumber], [Disabled], [Installer], [Retail], [ServiceContractor], [Repair], [Wholesaler], [StateLicense], [NumberOfInstallers], [ResaleCertificate], [Commercial], [Residential], [Tankless], [ManufacturedHome], [ServiceWhatWeSell], [ServiceCommercialElectric], [ServiceCommercialGas], [ServiceResidentialElectric], [ServiceResidentialGas], [ServiceMobileHomeElectric], [ServiceMobileHomeGas], [ServiceTanklessElectric], [ServiceTanklessGas], [ServiceSolar], [TwentyFourHourServiceMF], [TwentyFourHourServiceSat], [TwentyFourHourServiceSun], [LicensedPlumber], [ShowRoom], [ShowOnLocator], [SellProduct], [NewInstallation], [ReplacementInstallation], [ContractDate], [ContractExpiration], [LicenseExpiration], [InsuranceExpiration], [BusinessExpiration], [PlumbingExpiration], [ResaleExpiration], [ProClubMember], [ProClubActive], [ProClubNumber], [PastPro], [FileDate], [Rating], [Rheem], [Ruud], [Richmond], [PrivateLabel], [HomeDepot], [GE], [NoGE], [Vanguard], [RheemTankless], [RuudTankless], [RheemTank], [RuudTank], [RichmondTankless], [PalomaTankless], [LocatorPlacement], [DistributorOrganizationID], [NoAddressOnConsumer]
	FROM [ContractorWaterHeater]
	WHERE ' +  @searchParam

	EXEC(@strSql)
	
	--//We should NOT be using exec above.
	--//If params are NOT known, then be sure to clean sql
	--//If params are known, format like example below
	
	--IF @prodname IS NOT NULL
	--SELECT @sql = @sql + ' ProductName LIKE @prodname'
	--EXEC sp_executesql @sql, N'@prodname varchar(400)',@prodname
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: SearchContractorWaterHeaterByString Succeeded'
Else PRINT 'Procedure Creation: SearchContractorWaterHeaterByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorWaterHeater') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContractorWaterHeater;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContractorWaterHeater
   
   Description:  Updates a record In table 'ContractorWaterHeater'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContractorWaterHeater
(
	@ContractorWaterHeaterID uniqueidentifier, 
	@OrganizationID uniqueidentifier, 
	@WHNumber varchar(50), 
	@VendorNumber varchar(50), 
	@Disabled bit, 
	@Installer bit, 
	@Retail bit, 
	@ServiceContractor bit, 
	@Repair bit, 
	@Wholesaler bit, 
	@StateLicense varchar(50), 
	@NumberOfInstallers int, 
	@ResaleCertificate varchar(50), 
	@Commercial bit, 
	@Residential bit, 
	@Tankless bit, 
	@ManufacturedHome bit, 
	@ServiceWhatWeSell bit, 
	@ServiceCommercialElectric bit, 
	@ServiceCommercialGas bit, 
	@ServiceResidentialElectric bit, 
	@ServiceResidentialGas bit, 
	@ServiceMobileHomeElectric bit, 
	@ServiceMobileHomeGas bit, 
	@ServiceTanklessElectric bit, 
	@ServiceTanklessGas bit, 
	@ServiceSolar bit, 
	@TwentyFourHourServiceMF bit, 
	@TwentyFourHourServiceSat bit, 
	@TwentyFourHourServiceSun bit, 
	@LicensedPlumber bit, 
	@ShowRoom bit, 
	@ShowOnLocator bit, 
	@SellProduct bit, 
	@NewInstallation bit, 
	@ReplacementInstallation bit, 
	@ContractDate datetime, 
	@ContractExpiration datetime, 
	@LicenseExpiration datetime, 
	@InsuranceExpiration datetime, 
	@BusinessExpiration datetime, 
	@PlumbingExpiration datetime, 
	@ResaleExpiration datetime, 
	@ProClubMember bit, 
	@ProClubActive bit, 
	@ProClubNumber int, 
	@PastPro varchar(50), 
	@FileDate datetime, 
	@Rating int, 
	@Rheem bit, 
	@Ruud bit, 
	@Richmond bit, 
	@PrivateLabel bit, 
	@HomeDepot bit, 
	@GE bit, 
	@NoGE bit, 
	@Vanguard bit, 
	@RheemTankless bit, 
	@RuudTankless bit, 
	@RheemTank bit, 
	@RuudTank bit, 
	@RichmondTankless bit, 
	@PalomaTankless bit, 
	@LocatorPlacement int, 
	@DistributorOrganizationID uniqueidentifier, 
	@NoAddressOnConsumer bit

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContractorWaterHeater]
	SET
	[ContractorWaterHeaterID] = @ContractorWaterHeaterID, 
	[OrganizationID] = @OrganizationID, 
	[WHNumber] = @WHNumber, 
	[VendorNumber] = @VendorNumber, 
	[Disabled] = @Disabled, 
	[Installer] = @Installer, 
	[Retail] = @Retail, 
	[ServiceContractor] = @ServiceContractor, 
	[Repair] = @Repair, 
	[Wholesaler] = @Wholesaler, 
	[StateLicense] = @StateLicense, 
	[NumberOfInstallers] = @NumberOfInstallers, 
	[ResaleCertificate] = @ResaleCertificate, 
	[Commercial] = @Commercial, 
	[Residential] = @Residential, 
	[Tankless] = @Tankless, 
	[ManufacturedHome] = @ManufacturedHome, 
	[ServiceWhatWeSell] = @ServiceWhatWeSell, 
	[ServiceCommercialElectric] = @ServiceCommercialElectric, 
	[ServiceCommercialGas] = @ServiceCommercialGas, 
	[ServiceResidentialElectric] = @ServiceResidentialElectric, 
	[ServiceResidentialGas] = @ServiceResidentialGas, 
	[ServiceMobileHomeElectric] = @ServiceMobileHomeElectric, 
	[ServiceMobileHomeGas] = @ServiceMobileHomeGas, 
	[ServiceTanklessElectric] = @ServiceTanklessElectric, 
	[ServiceTanklessGas] = @ServiceTanklessGas, 
	[ServiceSolar] = @ServiceSolar, 
	[TwentyFourHourServiceMF] = @TwentyFourHourServiceMF, 
	[TwentyFourHourServiceSat] = @TwentyFourHourServiceSat, 
	[TwentyFourHourServiceSun] = @TwentyFourHourServiceSun, 
	[LicensedPlumber] = @LicensedPlumber, 
	[ShowRoom] = @ShowRoom, 
	[ShowOnLocator] = @ShowOnLocator, 
	[SellProduct] = @SellProduct, 
	[NewInstallation] = @NewInstallation, 
	[ReplacementInstallation] = @ReplacementInstallation, 
	[ContractDate] = @ContractDate, 
	[ContractExpiration] = @ContractExpiration, 
	[LicenseExpiration] = @LicenseExpiration, 
	[InsuranceExpiration] = @InsuranceExpiration, 
	[BusinessExpiration] = @BusinessExpiration, 
	[PlumbingExpiration] = @PlumbingExpiration, 
	[ResaleExpiration] = @ResaleExpiration, 
	[ProClubMember] = @ProClubMember, 
	[ProClubActive] = @ProClubActive, 
	[ProClubNumber] = @ProClubNumber, 
	[PastPro] = @PastPro, 
	[FileDate] = @FileDate, 
	[Rating] = @Rating, 
	[Rheem] = @Rheem, 
	[Ruud] = @Ruud, 
	[Richmond] = @Richmond, 
	[PrivateLabel] = @PrivateLabel, 
	[HomeDepot] = @HomeDepot, 
	[GE] = @GE, 
	[NoGE] = @NoGE, 
	[Vanguard] = @Vanguard, 
	[RheemTankless] = @RheemTankless, 
	[RuudTankless] = @RuudTankless, 
	[RheemTank] = @RheemTank, 
	[RuudTank] = @RuudTank, 
	[RichmondTankless] = @RichmondTankless, 
	[PalomaTankless] = @PalomaTankless, 
	[LocatorPlacement] = @LocatorPlacement, 
	[DistributorOrganizationID] = @DistributorOrganizationID, 
	[NoAddressOnConsumer] = @NoAddressOnConsumer

	WHERE [ContractorWaterHeaterID] = @ContractorWaterHeaterID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContractorWaterHeater Succeeded'
Else PRINT 'Procedure Creation: UpdateContractorWaterHeater Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorWaterHeater') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContractorWaterHeater;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorWaterHeater
   
   Description:  Deletes a record from table 'ContractorWaterHeater'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContractorWaterHeater
(
	@ContractorWaterHeaterID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorWaterHeater] 
	WHERE [ContractorWaterHeaterID] = @ContractorWaterHeaterID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContractorWaterHeater Succeeded'
Else PRINT 'Procedure Creation: DeleteContractorWaterHeater Error on Creation'
GO
		
		
