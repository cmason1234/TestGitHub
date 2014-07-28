


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContractorGenerator'
   
   AUTHOR:       Mike Harvey - 11/1/2010 9:06:03 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorGenerator') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContractorGenerator;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContractorGenerator
   
   Description:  Inserts a record into table 'ContractorGenerator'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContractorGenerator
(
	@ContractorGeneratorID uniqueidentifier = null output,
	@OrganizationID uniqueidentifier, 
	@DistributorOrganizationID uniqueidentifier, 
	@BrandID uniqueidentifier, 
	@ShowOnLocator bit, 
	@Disabled bit, 
	@GeneratorNumber int, 
	@Cashback bit
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @ContractorGeneratorID = NewID()
	

	INSERT
	INTO [ContractorGenerator]
	(
		[ContractorGeneratorID], 
		[OrganizationID], 
		[DistributorOrganizationID], 
		[BrandID], 
		[ShowOnLocator], 
		[Disabled], 
		[GeneratorNumber], 
		[Cashback]
	)
	VALUES
	(
		@ContractorGeneratorID, 
		@OrganizationID, 
		@DistributorOrganizationID, 
		@BrandID, 
		@ShowOnLocator, 
		@Disabled, 
		@GeneratorNumber, 
		@Cashback

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContractorGenerator Succeeded'
Else PRINT 'Procedure Creation: InsertContractorGenerator Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorGeneratorByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContractorGeneratorByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContractorGeneratorByID
   
   Description:  Selects record(s) from table 'ContractorGenerator'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContractorGeneratorByID
(
	@ContractorGeneratorID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[ContractorGeneratorID], [OrganizationID], [DistributorOrganizationID], [BrandID], [ShowOnLocator], [Disabled], [GeneratorNumber], [Cashback]
	FROM [ContractorGenerator]
	WHERE [ContractorGeneratorID] = @ContractorGeneratorID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContractorGeneratorByID Succeeded'
Else PRINT 'Procedure Creation: GetContractorGeneratorByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorGeneratorByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContractorGeneratorByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContractorGeneratorByString
   
   Description:  Selects a record from table 'ContractorGenerator'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContractorGeneratorByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[ContractorGeneratorID], [OrganizationID], [DistributorOrganizationID], [BrandID], [ShowOnLocator], [Disabled], [GeneratorNumber], [Cashback]
	FROM [ContractorGenerator]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchContractorGeneratorByString Succeeded'
Else PRINT 'Procedure Creation: SearchContractorGeneratorByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorGenerator') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContractorGenerator;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContractorGenerator
   
   Description:  Updates a record In table 'ContractorGenerator'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContractorGenerator
(
	@ContractorGeneratorID uniqueidentifier, 
	@OrganizationID uniqueidentifier, 
	@DistributorOrganizationID uniqueidentifier, 
	@BrandID uniqueidentifier, 
	@ShowOnLocator bit, 
	@Disabled bit, 
	@GeneratorNumber int, 
	@Cashback bit

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContractorGenerator]
	SET
	[ContractorGeneratorID] = @ContractorGeneratorID, 
	[OrganizationID] = @OrganizationID, 
	[DistributorOrganizationID] = @DistributorOrganizationID, 
	[BrandID] = @BrandID, 
	[ShowOnLocator] = @ShowOnLocator, 
	[Disabled] = @Disabled, 
	[GeneratorNumber] = @GeneratorNumber, 
	[Cashback] = @Cashback

	WHERE [ContractorGeneratorID] = @ContractorGeneratorID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContractorGenerator Succeeded'
Else PRINT 'Procedure Creation: UpdateContractorGenerator Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorGenerator') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContractorGenerator;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorGenerator
   
   Description:  Deletes a record from table 'ContractorGenerator'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContractorGenerator
(
	@ContractorGeneratorID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorGenerator] 
	WHERE [ContractorGeneratorID] = @ContractorGeneratorID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContractorGenerator Succeeded'
Else PRINT 'Procedure Creation: DeleteContractorGenerator Error on Creation'
GO
		
		
