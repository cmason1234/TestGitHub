


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContractorRates'
   
   AUTHOR:       Mike Harvey - 11/1/2010 9:06:03 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorRates') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContractorRates;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContractorRates
   
   Description:  Inserts a record into table 'ContractorRates'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContractorRates
(
	@ContractorRateID uniqueidentifier = null output,
	@OrganizationID uniqueidentifier, 
	@RateType varchar(50) = null, 
	@ResidentialRepairPerHour float, 
	@ResidentialRepairMax float, 
	@ResidentialReplacementPerHour float, 
	@ResidentialReplacementMax float, 
	@CommercialRepairPerHour float, 
	@CommercialRepairMax float, 
	@CommercialReplacementPerHour float, 
	@CommercialReplacementMax float, 
	@TanklessRepairPerHour float, 
	@TanklessRepairMax float, 
	@TanklessReplacementPerHour float, 
	@TanklessReplacementMax float, 
	@TravelAllowanceRangeOneMiles float, 
	@TravelAllowanceRangeOneRate float, 
	@TravelAllowanceRangeTwoMiles float, 
	@TravelAllowanceRangeTwoRate float, 
	@TravelAllowanceRangeThreeRate float, 
	@ZipCodeZoneZero float, 
	@ZipCodeZoneOne float, 
	@ZipCodeZoneTwo float, 
	@ZipCodeZoneThree float, 
	@TimeZone char(1) = null, 
	@TwentyFourHourRate varchar(128) = null, 
	@Comment text = null
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @ContractorRateID = NewID()
	

	INSERT
	INTO [ContractorRates]
	(
		[ContractorRateID], 
		[OrganizationID], 
		[RateType], 
		[ResidentialRepairPerHour], 
		[ResidentialRepairMax], 
		[ResidentialReplacementPerHour], 
		[ResidentialReplacementMax], 
		[CommercialRepairPerHour], 
		[CommercialRepairMax], 
		[CommercialReplacementPerHour], 
		[CommercialReplacementMax], 
		[TanklessRepairPerHour], 
		[TanklessRepairMax], 
		[TanklessReplacementPerHour], 
		[TanklessReplacementMax], 
		[TravelAllowanceRangeOneMiles], 
		[TravelAllowanceRangeOneRate], 
		[TravelAllowanceRangeTwoMiles], 
		[TravelAllowanceRangeTwoRate], 
		[TravelAllowanceRangeThreeRate], 
		[ZipCodeZoneZero], 
		[ZipCodeZoneOne], 
		[ZipCodeZoneTwo], 
		[ZipCodeZoneThree], 
		[TimeZone], 
		[TwentyFourHourRate], 
		[Comment]
	)
	VALUES
	(
		@ContractorRateID, 
		@OrganizationID, 
		@RateType, 
		@ResidentialRepairPerHour, 
		@ResidentialRepairMax, 
		@ResidentialReplacementPerHour, 
		@ResidentialReplacementMax, 
		@CommercialRepairPerHour, 
		@CommercialRepairMax, 
		@CommercialReplacementPerHour, 
		@CommercialReplacementMax, 
		@TanklessRepairPerHour, 
		@TanklessRepairMax, 
		@TanklessReplacementPerHour, 
		@TanklessReplacementMax, 
		@TravelAllowanceRangeOneMiles, 
		@TravelAllowanceRangeOneRate, 
		@TravelAllowanceRangeTwoMiles, 
		@TravelAllowanceRangeTwoRate, 
		@TravelAllowanceRangeThreeRate, 
		@ZipCodeZoneZero, 
		@ZipCodeZoneOne, 
		@ZipCodeZoneTwo, 
		@ZipCodeZoneThree, 
		@TimeZone, 
		@TwentyFourHourRate, 
		@Comment

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContractorRates Succeeded'
Else PRINT 'Procedure Creation: InsertContractorRates Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorRatesByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContractorRatesByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContractorRatesByID
   
   Description:  Selects record(s) from table 'ContractorRates'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContractorRatesByID
(
	@ContractorRateID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[ContractorRateID], [OrganizationID], [RateType], [ResidentialRepairPerHour], [ResidentialRepairMax], [ResidentialReplacementPerHour], [ResidentialReplacementMax], [CommercialRepairPerHour], [CommercialRepairMax], [CommercialReplacementPerHour], [CommercialReplacementMax], [TanklessRepairPerHour], [TanklessRepairMax], [TanklessReplacementPerHour], [TanklessReplacementMax], [TravelAllowanceRangeOneMiles], [TravelAllowanceRangeOneRate], [TravelAllowanceRangeTwoMiles], [TravelAllowanceRangeTwoRate], [TravelAllowanceRangeThreeRate], [ZipCodeZoneZero], [ZipCodeZoneOne], [ZipCodeZoneTwo], [ZipCodeZoneThree], [TimeZone], [TwentyFourHourRate], [Comment]
	FROM [ContractorRates]
	WHERE [ContractorRateID] = @ContractorRateID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContractorRatesByID Succeeded'
Else PRINT 'Procedure Creation: GetContractorRatesByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorRatesByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContractorRatesByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContractorRatesByString
   
   Description:  Selects a record from table 'ContractorRates'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContractorRatesByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[ContractorRateID], [OrganizationID], [RateType], [ResidentialRepairPerHour], [ResidentialRepairMax], [ResidentialReplacementPerHour], [ResidentialReplacementMax], [CommercialRepairPerHour], [CommercialRepairMax], [CommercialReplacementPerHour], [CommercialReplacementMax], [TanklessRepairPerHour], [TanklessRepairMax], [TanklessReplacementPerHour], [TanklessReplacementMax], [TravelAllowanceRangeOneMiles], [TravelAllowanceRangeOneRate], [TravelAllowanceRangeTwoMiles], [TravelAllowanceRangeTwoRate], [TravelAllowanceRangeThreeRate], [ZipCodeZoneZero], [ZipCodeZoneOne], [ZipCodeZoneTwo], [ZipCodeZoneThree], [TimeZone], [TwentyFourHourRate], [Comment]
	FROM [ContractorRates]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchContractorRatesByString Succeeded'
Else PRINT 'Procedure Creation: SearchContractorRatesByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorRates') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContractorRates;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContractorRates
   
   Description:  Updates a record In table 'ContractorRates'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContractorRates
(
	@ContractorRateID uniqueidentifier, 
	@OrganizationID uniqueidentifier, 
	@RateType varchar(50), 
	@ResidentialRepairPerHour float, 
	@ResidentialRepairMax float, 
	@ResidentialReplacementPerHour float, 
	@ResidentialReplacementMax float, 
	@CommercialRepairPerHour float, 
	@CommercialRepairMax float, 
	@CommercialReplacementPerHour float, 
	@CommercialReplacementMax float, 
	@TanklessRepairPerHour float, 
	@TanklessRepairMax float, 
	@TanklessReplacementPerHour float, 
	@TanklessReplacementMax float, 
	@TravelAllowanceRangeOneMiles float, 
	@TravelAllowanceRangeOneRate float, 
	@TravelAllowanceRangeTwoMiles float, 
	@TravelAllowanceRangeTwoRate float, 
	@TravelAllowanceRangeThreeRate float, 
	@ZipCodeZoneZero float, 
	@ZipCodeZoneOne float, 
	@ZipCodeZoneTwo float, 
	@ZipCodeZoneThree float, 
	@TimeZone char(1), 
	@TwentyFourHourRate varchar(128), 
	@Comment text

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContractorRates]
	SET
	[ContractorRateID] = @ContractorRateID, 
	[OrganizationID] = @OrganizationID, 
	[RateType] = @RateType, 
	[ResidentialRepairPerHour] = @ResidentialRepairPerHour, 
	[ResidentialRepairMax] = @ResidentialRepairMax, 
	[ResidentialReplacementPerHour] = @ResidentialReplacementPerHour, 
	[ResidentialReplacementMax] = @ResidentialReplacementMax, 
	[CommercialRepairPerHour] = @CommercialRepairPerHour, 
	[CommercialRepairMax] = @CommercialRepairMax, 
	[CommercialReplacementPerHour] = @CommercialReplacementPerHour, 
	[CommercialReplacementMax] = @CommercialReplacementMax, 
	[TanklessRepairPerHour] = @TanklessRepairPerHour, 
	[TanklessRepairMax] = @TanklessRepairMax, 
	[TanklessReplacementPerHour] = @TanklessReplacementPerHour, 
	[TanklessReplacementMax] = @TanklessReplacementMax, 
	[TravelAllowanceRangeOneMiles] = @TravelAllowanceRangeOneMiles, 
	[TravelAllowanceRangeOneRate] = @TravelAllowanceRangeOneRate, 
	[TravelAllowanceRangeTwoMiles] = @TravelAllowanceRangeTwoMiles, 
	[TravelAllowanceRangeTwoRate] = @TravelAllowanceRangeTwoRate, 
	[TravelAllowanceRangeThreeRate] = @TravelAllowanceRangeThreeRate, 
	[ZipCodeZoneZero] = @ZipCodeZoneZero, 
	[ZipCodeZoneOne] = @ZipCodeZoneOne, 
	[ZipCodeZoneTwo] = @ZipCodeZoneTwo, 
	[ZipCodeZoneThree] = @ZipCodeZoneThree, 
	[TimeZone] = @TimeZone, 
	[TwentyFourHourRate] = @TwentyFourHourRate, 
	[Comment] = @Comment

	WHERE [ContractorRateID] = @ContractorRateID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContractorRates Succeeded'
Else PRINT 'Procedure Creation: UpdateContractorRates Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorRates') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContractorRates;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorRates
   
   Description:  Deletes a record from table 'ContractorRates'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContractorRates
(
	@ContractorRateID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorRates] 
	WHERE [ContractorRateID] = @ContractorRateID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContractorRates Succeeded'
Else PRINT 'Procedure Creation: DeleteContractorRates Error on Creation'
GO
		
		
