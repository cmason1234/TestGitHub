


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContractorRetail'
   
   AUTHOR:       Mike Harvey - 11/1/2010 9:06:04 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorRetail') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContractorRetail;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContractorRetail
   
   Description:  Inserts a record into table 'ContractorRetail'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContractorRetail
(
	@ContractorRetailID uniqueidentifier = null output,
	@OrganizationID uniqueidentifier, 
	@HomeDepot bit, 
	@HDVendorNumber int, 
	@Contact varchar(50) = null, 
	@Disabled bit, 
	@HDCashback bit, 
	@PersonCreated datetime
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @ContractorRetailID = NewID()
	

	INSERT
	INTO [ContractorRetail]
	(
		[ContractorRetailID], 
		[OrganizationID], 
		[HomeDepot], 
		[HDVendorNumber], 
		[Contact], 
		[Disabled], 
		[HDCashback], 
		[PersonCreated]
	)
	VALUES
	(
		@ContractorRetailID, 
		@OrganizationID, 
		@HomeDepot, 
		@HDVendorNumber, 
		@Contact, 
		@Disabled, 
		@HDCashback, 
		@PersonCreated

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContractorRetail Succeeded'
Else PRINT 'Procedure Creation: InsertContractorRetail Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorRetailByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContractorRetailByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContractorRetailByID
   
   Description:  Selects record(s) from table 'ContractorRetail'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContractorRetailByID
(
	@ContractorRetailID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[ContractorRetailID], [OrganizationID], [HomeDepot], [HDVendorNumber], [Contact], [Disabled], [HDCashback], [PersonCreated]
	FROM [ContractorRetail]
	WHERE [ContractorRetailID] = @ContractorRetailID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContractorRetailByID Succeeded'
Else PRINT 'Procedure Creation: GetContractorRetailByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorRetailByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContractorRetailByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContractorRetailByString
   
   Description:  Selects a record from table 'ContractorRetail'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContractorRetailByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[ContractorRetailID], [OrganizationID], [HomeDepot], [HDVendorNumber], [Contact], [Disabled], [HDCashback], [PersonCreated]
	FROM [ContractorRetail]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchContractorRetailByString Succeeded'
Else PRINT 'Procedure Creation: SearchContractorRetailByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorRetail') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContractorRetail;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContractorRetail
   
   Description:  Updates a record In table 'ContractorRetail'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContractorRetail
(
	@ContractorRetailID uniqueidentifier, 
	@OrganizationID uniqueidentifier, 
	@HomeDepot bit, 
	@HDVendorNumber int, 
	@Contact varchar(50), 
	@Disabled bit, 
	@HDCashback bit, 
	@PersonCreated datetime

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContractorRetail]
	SET
	[ContractorRetailID] = @ContractorRetailID, 
	[OrganizationID] = @OrganizationID, 
	[HomeDepot] = @HomeDepot, 
	[HDVendorNumber] = @HDVendorNumber, 
	[Contact] = @Contact, 
	[Disabled] = @Disabled, 
	[HDCashback] = @HDCashback, 
	[PersonCreated] = @PersonCreated

	WHERE [ContractorRetailID] = @ContractorRetailID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContractorRetail Succeeded'
Else PRINT 'Procedure Creation: UpdateContractorRetail Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorRetail') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContractorRetail;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorRetail
   
   Description:  Deletes a record from table 'ContractorRetail'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContractorRetail
(
	@ContractorRetailID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorRetail] 
	WHERE [ContractorRetailID] = @ContractorRetailID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContractorRetail Succeeded'
Else PRINT 'Procedure Creation: DeleteContractorRetail Error on Creation'
GO
		
		
