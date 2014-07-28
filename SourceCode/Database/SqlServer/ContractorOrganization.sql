


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContractorOrganization'
   
   AUTHOR:       Mike Harvey - 11/1/2010 9:06:03 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorOrganization') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContractorOrganization;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContractorOrganization
   
   Description:  Inserts a record into table 'ContractorOrganization'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContractorOrganization
(
	@ContractorOrganizationID uniqueidentifier = null output,
	@OrganizationID uniqueidentifier, 
	@ACContractor bit, 
	@WaterHeaterContractor bit, 
	@PoolAndSpaContractor bit, 
	@GeneratorContractor bit, 
	@ServiceContractorDELETE bit, 
	@Installer bit, 
	@Disabled bit, 
	@KwikComfort bit, 
	@KwikComfortNumber varchar(50) = null, 
	@CorporateEmail varchar(50) = null, 
	@CountryID uniqueidentifier, 
	@WebSite varchar(128) = null, 
	@MarketID uniqueidentifier, 
	@Radius float, 
	@FederalID varchar(50) = null, 
	@BusinessType char(1) = null, 
	@PrimaryAddressID uniqueidentifier, 
	@FollowUp bit, 
	@SSN varchar(50) = null, 
	@TAP bit, 
	@RetailContractor bit, 
	@ZipCodesUpdated datetime, 
	@FactoryDirectContractor bit,
	@ServiceExperts bit
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @ContractorOrganizationID = NewID()
	

	INSERT
	INTO [ContractorOrganization]
	(
		[ContractorOrganizationID], 
		[OrganizationID], 
		[ACContractor], 
		[WaterHeaterContractor], 
		[PoolAndSpaContractor], 
		[GeneratorContractor], 
		[ServiceContractorDELETE], 
		[Installer], 
		[Disabled], 
		[KwikComfort], 
		[KwikComfortNumber], 
		[CorporateEmail], 
		[CountryID], 
		[WebSite], 
		[MarketID], 
		[Radius], 
		[FederalID], 
		[BusinessType], 
		[PrimaryAddressID], 
		[FollowUp], 
		[SSN], 
		[TAP], 
		[RetailContractor], 
		[ZipCodesUpdated], 
		[FactoryDirectContractor],
		[ServiceExperts]
	)
	VALUES
	(
		@ContractorOrganizationID, 
		@OrganizationID, 
		@ACContractor, 
		@WaterHeaterContractor, 
		@PoolAndSpaContractor, 
		@GeneratorContractor, 
		@ServiceContractorDELETE, 
		@Installer, 
		@Disabled, 
		@KwikComfort, 
		@KwikComfortNumber, 
		@CorporateEmail, 
		@CountryID, 
		@WebSite, 
		@MarketID, 
		@Radius, 
		@FederalID, 
		@BusinessType, 
		@PrimaryAddressID, 
		@FollowUp, 
		@SSN, 
		@TAP, 
		@RetailContractor, 
		@ZipCodesUpdated, 
		@FactoryDirectContractor,
		@ServiceExperts

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContractorOrganization Succeeded'
Else PRINT 'Procedure Creation: InsertContractorOrganization Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorOrganizationByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContractorOrganizationByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContractorOrganizationByID
   
   Description:  Selects record(s) from table 'ContractorOrganization'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContractorOrganizationByID
(
	@ContractorOrganizationID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[ContractorOrganizationID], [OrganizationID], [ACContractor], [WaterHeaterContractor], [PoolAndSpaContractor], [GeneratorContractor], [ServiceContractorDELETE], [Installer], [Disabled], [KwikComfort], [KwikComfortNumber], [CorporateEmail], [CountryID], [WebSite], [MarketID], [Radius], [FederalID], [BusinessType], [PrimaryAddressID], [FollowUp], [SSN], [TAP], [RetailContractor], [ZipCodesUpdated], [FactoryDirectContractor], [ServiceExperts]
	FROM [ContractorOrganization]
	WHERE [ContractorOrganizationID] = @ContractorOrganizationID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContractorOrganizationByID Succeeded'
Else PRINT 'Procedure Creation: GetContractorOrganizationByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorOrganizationByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContractorOrganizationByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContractorOrganizationByString
   
   Description:  Selects a record from table 'ContractorOrganization'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContractorOrganizationByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[ContractorOrganizationID], [OrganizationID], [ACContractor], [WaterHeaterContractor], [PoolAndSpaContractor], [GeneratorContractor], [ServiceContractorDELETE], [Installer], [Disabled], [KwikComfort], [KwikComfortNumber], [CorporateEmail], [CountryID], [WebSite], [MarketID], [Radius], [FederalID], [BusinessType], [PrimaryAddressID], [FollowUp], [SSN], [TAP], [RetailContractor], [ZipCodesUpdated], [FactoryDirectContractor], [ServiceExperts]
	FROM [ContractorOrganization]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchContractorOrganizationByString Succeeded'
Else PRINT 'Procedure Creation: SearchContractorOrganizationByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorOrganization') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContractorOrganization;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContractorOrganization
   
   Description:  Updates a record In table 'ContractorOrganization'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContractorOrganization
(
	@ContractorOrganizationID uniqueidentifier, 
	@OrganizationID uniqueidentifier, 
	@ACContractor bit, 
	@WaterHeaterContractor bit, 
	@PoolAndSpaContractor bit, 
	@GeneratorContractor bit, 
	@ServiceContractorDELETE bit, 
	@Installer bit, 
	@Disabled bit, 
	@KwikComfort bit, 
	@KwikComfortNumber varchar(50), 
	@CorporateEmail varchar(50), 
	@CountryID uniqueidentifier, 
	@WebSite varchar(128), 
	@MarketID uniqueidentifier, 
	@Radius float, 
	@FederalID varchar(50), 
	@BusinessType char(1), 
	@PrimaryAddressID uniqueidentifier, 
	@FollowUp bit, 
	@SSN varchar(50), 
	@TAP bit, 
	@RetailContractor bit, 
	@ZipCodesUpdated datetime, 
	@FactoryDirectContractor bit,
	@ServiceExperts bit

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContractorOrganization]
	SET
	[ContractorOrganizationID] = @ContractorOrganizationID, 
	[OrganizationID] = @OrganizationID, 
	[ACContractor] = @ACContractor, 
	[WaterHeaterContractor] = @WaterHeaterContractor, 
	[PoolAndSpaContractor] = @PoolAndSpaContractor, 
	[GeneratorContractor] = @GeneratorContractor, 
	[ServiceContractorDELETE] = @ServiceContractorDELETE, 
	[Installer] = @Installer, 
	[Disabled] = @Disabled, 
	[KwikComfort] = @KwikComfort, 
	[KwikComfortNumber] = @KwikComfortNumber, 
	[CorporateEmail] = @CorporateEmail, 
	[CountryID] = @CountryID, 
	[WebSite] = @WebSite, 
	[MarketID] = @MarketID, 
	[Radius] = @Radius, 
	[FederalID] = @FederalID, 
	[BusinessType] = @BusinessType, 
	[PrimaryAddressID] = @PrimaryAddressID, 
	[FollowUp] = @FollowUp, 
	[SSN] = @SSN, 
	[TAP] = @TAP, 
	[RetailContractor] = @RetailContractor, 
	[ZipCodesUpdated] = @ZipCodesUpdated, 
	[FactoryDirectContractor] = @FactoryDirectContractor,
	[ServiceExperts] = @ServiceExperts

	WHERE [ContractorOrganizationID] = @ContractorOrganizationID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContractorOrganization Succeeded'
Else PRINT 'Procedure Creation: UpdateContractorOrganization Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorOrganization') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContractorOrganization;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorOrganization
   
   Description:  Deletes a record from table 'ContractorOrganization'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContractorOrganization
(
	@ContractorOrganizationID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorOrganization] 
	WHERE [ContractorOrganizationID] = @ContractorOrganizationID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContractorOrganization Succeeded'
Else PRINT 'Procedure Creation: DeleteContractorOrganization Error on Creation'
GO
		
		
