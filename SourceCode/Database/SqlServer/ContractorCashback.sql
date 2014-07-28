


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContractorCashback'
   
   AUTHOR:       Mike Harvey - 11/1/2010 9:06:03 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorCashback') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContractorCashback;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContractorCashback
   
   Description:  Inserts a record into table 'ContractorCashback'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContractorCashback
(
	@ContractorCashbackID uniqueidentifier = null output,
	@ProgramYear int, 
	@OrganizationID uniqueidentifier, 
	@CashBackSpecialText text = null, 
	@CashbackProgram varchar(50) = null
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @ContractorCashbackID = NewID()
	

	INSERT
	INTO [ContractorCashback]
	(
		[ContractorCashbackID], 
		[ProgramYear], 
		[OrganizationID], 
		[CashBackSpecialText], 
		[CashbackProgram]
	)
	VALUES
	(
		@ContractorCashbackID, 
		@ProgramYear, 
		@OrganizationID, 
		@CashBackSpecialText, 
		@CashbackProgram

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContractorCashback Succeeded'
Else PRINT 'Procedure Creation: InsertContractorCashback Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorCashbackByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContractorCashbackByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContractorCashbackByID
   
   Description:  Selects record(s) from table 'ContractorCashback'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContractorCashbackByID
(
	@ContractorCashbackID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[ContractorCashbackID], [ProgramYear], [OrganizationID], [CashBackSpecialText], [CashbackProgram]
	FROM [ContractorCashback]
	WHERE [ContractorCashbackID] = @ContractorCashbackID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContractorCashbackByID Succeeded'
Else PRINT 'Procedure Creation: GetContractorCashbackByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorCashbackByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContractorCashbackByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContractorCashbackByString
   
   Description:  Selects a record from table 'ContractorCashback'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContractorCashbackByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[ContractorCashbackID], [ProgramYear], [OrganizationID], [CashBackSpecialText], [CashbackProgram]
	FROM [ContractorCashback]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchContractorCashbackByString Succeeded'
Else PRINT 'Procedure Creation: SearchContractorCashbackByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorCashback') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContractorCashback;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContractorCashback
   
   Description:  Updates a record In table 'ContractorCashback'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContractorCashback
(
	@ContractorCashbackID uniqueidentifier, 
	@ProgramYear int, 
	@OrganizationID uniqueidentifier, 
	@CashBackSpecialText text, 
	@CashbackProgram varchar(50)

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContractorCashback]
	SET
	[ContractorCashbackID] = @ContractorCashbackID, 
	[ProgramYear] = @ProgramYear, 
	[OrganizationID] = @OrganizationID, 
	[CashBackSpecialText] = @CashBackSpecialText, 
	[CashbackProgram] = @CashbackProgram

	WHERE [ContractorCashbackID] = @ContractorCashbackID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContractorCashback Succeeded'
Else PRINT 'Procedure Creation: UpdateContractorCashback Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorCashback') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContractorCashback;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorCashback
   
   Description:  Deletes a record from table 'ContractorCashback'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContractorCashback
(
	@ContractorCashbackID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorCashback] 
	WHERE [ContractorCashbackID] = @ContractorCashbackID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContractorCashback Succeeded'
Else PRINT 'Procedure Creation: DeleteContractorCashback Error on Creation'
GO
		
		
