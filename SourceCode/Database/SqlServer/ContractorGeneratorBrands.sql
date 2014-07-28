


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContractorGeneratorBrands'
   
   AUTHOR:       Mike Harvey - 11/1/2010 9:06:03 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorGeneratorBrands') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContractorGeneratorBrands;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContractorGeneratorBrands
   
   Description:  Inserts a record into table 'ContractorGeneratorBrands'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContractorGeneratorBrands
(
	@ContractorGeneratorBrandID uniqueidentifier = null output,
	@OrganizationID uniqueidentifier, 
	@BrandID uniqueidentifier
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @ContractorGeneratorBrandID = NewID()
	

	INSERT
	INTO [ContractorGeneratorBrands]
	(
		[ContractorGeneratorBrandID], 
		[OrganizationID], 
		[BrandID]
	)
	VALUES
	(
		@ContractorGeneratorBrandID, 
		@OrganizationID, 
		@BrandID

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContractorGeneratorBrands Succeeded'
Else PRINT 'Procedure Creation: InsertContractorGeneratorBrands Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorGeneratorBrandsByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContractorGeneratorBrandsByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContractorGeneratorBrandsByID
   
   Description:  Selects record(s) from table 'ContractorGeneratorBrands'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContractorGeneratorBrandsByID
(
	@ContractorGeneratorBrandID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[ContractorGeneratorBrandID], [OrganizationID], [BrandID]
	FROM [ContractorGeneratorBrands]
	WHERE [ContractorGeneratorBrandID] = @ContractorGeneratorBrandID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContractorGeneratorBrandsByID Succeeded'
Else PRINT 'Procedure Creation: GetContractorGeneratorBrandsByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorGeneratorBrandsByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContractorGeneratorBrandsByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContractorGeneratorBrandsByString
   
   Description:  Selects a record from table 'ContractorGeneratorBrands'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContractorGeneratorBrandsByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[ContractorGeneratorBrandID], [OrganizationID], [BrandID]
	FROM [ContractorGeneratorBrands]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchContractorGeneratorBrandsByString Succeeded'
Else PRINT 'Procedure Creation: SearchContractorGeneratorBrandsByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorGeneratorBrands') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContractorGeneratorBrands;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContractorGeneratorBrands
   
   Description:  Updates a record In table 'ContractorGeneratorBrands'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContractorGeneratorBrands
(
	@ContractorGeneratorBrandID uniqueidentifier, 
	@OrganizationID uniqueidentifier, 
	@BrandID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContractorGeneratorBrands]
	SET
	[ContractorGeneratorBrandID] = @ContractorGeneratorBrandID, 
	[OrganizationID] = @OrganizationID, 
	[BrandID] = @BrandID

	WHERE [ContractorGeneratorBrandID] = @ContractorGeneratorBrandID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContractorGeneratorBrands Succeeded'
Else PRINT 'Procedure Creation: UpdateContractorGeneratorBrands Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorGeneratorBrands') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContractorGeneratorBrands;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorGeneratorBrands
   
   Description:  Deletes a record from table 'ContractorGeneratorBrands'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContractorGeneratorBrands
(
	@ContractorGeneratorBrandID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorGeneratorBrands] 
	WHERE [ContractorGeneratorBrandID] = @ContractorGeneratorBrandID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContractorGeneratorBrands Succeeded'
Else PRINT 'Procedure Creation: DeleteContractorGeneratorBrands Error on Creation'
GO
		
		
