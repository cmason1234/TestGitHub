


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContractorFactoryDirect'
   
   AUTHOR:       Mike Harvey - 11/1/2010 9:06:03 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorFactoryDirect') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContractorFactoryDirect;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContractorFactoryDirect
   
   Description:  Inserts a record into table 'ContractorFactoryDirect'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContractorFactoryDirect
(
	@ContractorFactoryDirectID uniqueidentifier = null output,
	@OrganizationID uniqueidentifier
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @ContractorFactoryDirectID = NewID()
	

	INSERT
	INTO [ContractorFactoryDirect]
	(
		[ContractorFactoryDirectID], 
		[OrganizationID]
	)
	VALUES
	(
		@ContractorFactoryDirectID, 
		@OrganizationID

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContractorFactoryDirect Succeeded'
Else PRINT 'Procedure Creation: InsertContractorFactoryDirect Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorFactoryDirectByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContractorFactoryDirectByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContractorFactoryDirectByID
   
   Description:  Selects record(s) from table 'ContractorFactoryDirect'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContractorFactoryDirectByID
(
	@ContractorFactoryDirectID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[ContractorFactoryDirectID], [OrganizationID]
	FROM [ContractorFactoryDirect]
	WHERE [ContractorFactoryDirectID] = @ContractorFactoryDirectID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContractorFactoryDirectByID Succeeded'
Else PRINT 'Procedure Creation: GetContractorFactoryDirectByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorFactoryDirectByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContractorFactoryDirectByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContractorFactoryDirectByString
   
   Description:  Selects a record from table 'ContractorFactoryDirect'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContractorFactoryDirectByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[ContractorFactoryDirectID], [OrganizationID]
	FROM [ContractorFactoryDirect]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchContractorFactoryDirectByString Succeeded'
Else PRINT 'Procedure Creation: SearchContractorFactoryDirectByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorFactoryDirect') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContractorFactoryDirect;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContractorFactoryDirect
   
   Description:  Updates a record In table 'ContractorFactoryDirect'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContractorFactoryDirect
(
	@ContractorFactoryDirectID uniqueidentifier, 
	@OrganizationID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContractorFactoryDirect]
	SET
	[ContractorFactoryDirectID] = @ContractorFactoryDirectID, 
	[OrganizationID] = @OrganizationID

	WHERE [ContractorFactoryDirectID] = @ContractorFactoryDirectID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContractorFactoryDirect Succeeded'
Else PRINT 'Procedure Creation: UpdateContractorFactoryDirect Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorFactoryDirect') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContractorFactoryDirect;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorFactoryDirect
   
   Description:  Deletes a record from table 'ContractorFactoryDirect'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContractorFactoryDirect
(
	@ContractorFactoryDirectID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorFactoryDirect] 
	WHERE [ContractorFactoryDirectID] = @ContractorFactoryDirectID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContractorFactoryDirect Succeeded'
Else PRINT 'Procedure Creation: DeleteContractorFactoryDirect Error on Creation'
GO
		
		
