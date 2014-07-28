


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContractorRetailBrands'
   
   AUTHOR:       Mike Harvey - 11/1/2010 9:06:04 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorRetailBrands') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContractorRetailBrands;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContractorRetailBrands
   
   Description:  Inserts a record into table 'ContractorRetailBrands'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContractorRetailBrands
(
	@ContractorRetailBrandID uniqueidentifier = null output,
	@OrganizationID uniqueidentifier, 
	@BrandID uniqueidentifier
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @ContractorRetailBrandID = NewID()
	

	INSERT
	INTO [ContractorRetailBrands]
	(
		[ContractorRetailBrandID], 
		[OrganizationID], 
		[BrandID]
	)
	VALUES
	(
		@ContractorRetailBrandID, 
		@OrganizationID, 
		@BrandID

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContractorRetailBrands Succeeded'
Else PRINT 'Procedure Creation: InsertContractorRetailBrands Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorRetailBrandsByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContractorRetailBrandsByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContractorRetailBrandsByID
   
   Description:  Selects record(s) from table 'ContractorRetailBrands'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContractorRetailBrandsByID
(
	@ContractorRetailBrandID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[ContractorRetailBrandID], [OrganizationID], [BrandID]
	FROM [ContractorRetailBrands]
	WHERE [ContractorRetailBrandID] = @ContractorRetailBrandID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContractorRetailBrandsByID Succeeded'
Else PRINT 'Procedure Creation: GetContractorRetailBrandsByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorRetailBrandsByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContractorRetailBrandsByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContractorRetailBrandsByString
   
   Description:  Selects a record from table 'ContractorRetailBrands'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContractorRetailBrandsByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[ContractorRetailBrandID], [OrganizationID], [BrandID]
	FROM [ContractorRetailBrands]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchContractorRetailBrandsByString Succeeded'
Else PRINT 'Procedure Creation: SearchContractorRetailBrandsByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorRetailBrands') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContractorRetailBrands;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContractorRetailBrands
   
   Description:  Updates a record In table 'ContractorRetailBrands'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContractorRetailBrands
(
	@ContractorRetailBrandID uniqueidentifier, 
	@OrganizationID uniqueidentifier, 
	@BrandID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContractorRetailBrands]
	SET
	[ContractorRetailBrandID] = @ContractorRetailBrandID, 
	[OrganizationID] = @OrganizationID, 
	[BrandID] = @BrandID

	WHERE [ContractorRetailBrandID] = @ContractorRetailBrandID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContractorRetailBrands Succeeded'
Else PRINT 'Procedure Creation: UpdateContractorRetailBrands Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorRetailBrands') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContractorRetailBrands;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorRetailBrands
   
   Description:  Deletes a record from table 'ContractorRetailBrands'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:04 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContractorRetailBrands
(
	@ContractorRetailBrandID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorRetailBrands] 
	WHERE [ContractorRetailBrandID] = @ContractorRetailBrandID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContractorRetailBrands Succeeded'
Else PRINT 'Procedure Creation: DeleteContractorRetailBrands Error on Creation'
GO
		
		
