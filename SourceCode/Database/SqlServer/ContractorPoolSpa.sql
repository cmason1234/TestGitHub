


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContractorPoolSpa'
   
   AUTHOR:       Mike Harvey - 11/1/2010 9:06:03 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorPoolSpa') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContractorPoolSpa;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContractorPoolSpa
   
   Description:  Inserts a record into table 'ContractorPoolSpa'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContractorPoolSpa
(
	@ContractorPoolSpaID uniqueidentifier = null output,
	@OrganizationID uniqueidentifier, 
	@DistributorOrganizationID uniqueidentifier, 
	@ShowOnLocator bit, 
	@PoolSpaNumber int, 
	@Disabled bit, 
	@WarrantyServiceProvider bit
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @ContractorPoolSpaID = NewID()
	

	INSERT
	INTO [ContractorPoolSpa]
	(
		[ContractorPoolSpaID], 
		[OrganizationID], 
		[DistributorOrganizationID], 
		[ShowOnLocator], 
		[PoolSpaNumber], 
		[Disabled], 
		[WarrantyServiceProvider]
	)
	VALUES
	(
		@ContractorPoolSpaID, 
		@OrganizationID, 
		@DistributorOrganizationID, 
		@ShowOnLocator, 
		@PoolSpaNumber, 
		@Disabled, 
		@WarrantyServiceProvider

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContractorPoolSpa Succeeded'
Else PRINT 'Procedure Creation: InsertContractorPoolSpa Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorPoolSpaByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContractorPoolSpaByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContractorPoolSpaByID
   
   Description:  Selects record(s) from table 'ContractorPoolSpa'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContractorPoolSpaByID
(
	@ContractorPoolSpaID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[ContractorPoolSpaID], [OrganizationID], [DistributorOrganizationID], [ShowOnLocator], [PoolSpaNumber], [Disabled], [WarrantyServiceProvider]
	FROM [ContractorPoolSpa]
	WHERE [ContractorPoolSpaID] = @ContractorPoolSpaID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContractorPoolSpaByID Succeeded'
Else PRINT 'Procedure Creation: GetContractorPoolSpaByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorPoolSpaByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContractorPoolSpaByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContractorPoolSpaByString
   
   Description:  Selects a record from table 'ContractorPoolSpa'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContractorPoolSpaByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[ContractorPoolSpaID], [OrganizationID], [DistributorOrganizationID], [ShowOnLocator], [PoolSpaNumber], [Disabled], [WarrantyServiceProvider]
	FROM [ContractorPoolSpa]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchContractorPoolSpaByString Succeeded'
Else PRINT 'Procedure Creation: SearchContractorPoolSpaByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorPoolSpa') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContractorPoolSpa;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContractorPoolSpa
   
   Description:  Updates a record In table 'ContractorPoolSpa'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContractorPoolSpa
(
	@ContractorPoolSpaID uniqueidentifier, 
	@OrganizationID uniqueidentifier, 
	@DistributorOrganizationID uniqueidentifier, 
	@ShowOnLocator bit, 
	@PoolSpaNumber int, 
	@Disabled bit, 
	@WarrantyServiceProvider bit

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContractorPoolSpa]
	SET
	[ContractorPoolSpaID] = @ContractorPoolSpaID, 
	[OrganizationID] = @OrganizationID, 
	[DistributorOrganizationID] = @DistributorOrganizationID, 
	[ShowOnLocator] = @ShowOnLocator, 
	[PoolSpaNumber] = @PoolSpaNumber, 
	[Disabled] = @Disabled, 
	[WarrantyServiceProvider] = @WarrantyServiceProvider

	WHERE [ContractorPoolSpaID] = @ContractorPoolSpaID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContractorPoolSpa Succeeded'
Else PRINT 'Procedure Creation: UpdateContractorPoolSpa Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorPoolSpa') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContractorPoolSpa;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorPoolSpa
   
   Description:  Deletes a record from table 'ContractorPoolSpa'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContractorPoolSpa
(
	@ContractorPoolSpaID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorPoolSpa] 
	WHERE [ContractorPoolSpaID] = @ContractorPoolSpaID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContractorPoolSpa Succeeded'
Else PRINT 'Procedure Creation: DeleteContractorPoolSpa Error on Creation'
GO
		
		
