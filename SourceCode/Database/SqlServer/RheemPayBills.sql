


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'RheemPayBills'
   
   AUTHOR:       Brian White - 9/20/2010 12:06:31 PM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertRheemPayBills') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertRheemPayBills;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertRheemPayBills
   
   Description:  Inserts a record into table 'RheemPayBills'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/20/2010 12:06:31 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertRheemPayBills
(
	@RheemPayBillsID uniqueidentifier = null output,
	@BrandID uniqueidentifier, 
	@Name varchar(50) = null, 
	@Company varchar(50) = null, 
	@Address varchar(50) = null, 
	@City varchar(50) = null, 
	@PostalCode varchar(50) = null, 
	@PhoneNumber varchar(50) = null, 
	@EmailAddress varchar(50) = null, 
	@SerialNumber varchar(50) = null, 
	@ModelNumber varchar(50) = null, 
	@Wholesaler varchar(50) = null, 
	@RequestDate datetime, 
	@Promotion varchar(50) = null, 
	@MoreInfo int
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @RheemPayBillsID = NewID()
	

	INSERT
	INTO [RheemPayBills]
	(
		[RheemPayBillsID], 
		[BrandID], 
		[Name], 
		[Company], 
		[Address], 
		[City], 
		[PostalCode], 
		[PhoneNumber], 
		[EmailAddress], 
		[SerialNumber], 
		[ModelNumber], 
		[Wholesaler], 
		[RequestDate], 
		[Promotion], 
		[MoreInfo]
	)
	VALUES
	(
		@RheemPayBillsID, 
		@BrandID, 
		@Name, 
		@Company, 
		@Address, 
		@City, 
		@PostalCode, 
		@PhoneNumber, 
		@EmailAddress, 
		@SerialNumber, 
		@ModelNumber, 
		@Wholesaler, 
		@RequestDate, 
		@Promotion, 
		@MoreInfo

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertRheemPayBills Succeeded'
Else PRINT 'Procedure Creation: InsertRheemPayBills Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetRheemPayBillsByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetRheemPayBillsByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetRheemPayBillsByID
   
   Description:  Selects record(s) from table 'RheemPayBills'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/20/2010 12:06:31 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetRheemPayBillsByID
(
	@RheemPayBillsID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[RheemPayBillsID], [BrandID], [Name], [Company], [Address], [City], [PostalCode], [PhoneNumber], [EmailAddress], [SerialNumber], [ModelNumber], [Wholesaler], [RequestDate], [Promotion], [MoreInfo]
	FROM [RheemPayBills]
	WHERE [RheemPayBillsID] = @RheemPayBillsID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetRheemPayBillsByID Succeeded'
Else PRINT 'Procedure Creation: GetRheemPayBillsByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchRheemPayBillsByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchRheemPayBillsByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchRheemPayBillsByString
   
   Description:  Selects a record from table 'RheemPayBills'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/20/2010 12:06:31 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchRheemPayBillsByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[RheemPayBillsID], [BrandID], [Name], [Company], [Address], [City], [PostalCode], [PhoneNumber], [EmailAddress], [SerialNumber], [ModelNumber], [Wholesaler], [RequestDate], [Promotion], [MoreInfo]
	FROM [RheemPayBills]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchRheemPayBillsByString Succeeded'
Else PRINT 'Procedure Creation: SearchRheemPayBillsByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateRheemPayBills') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateRheemPayBills;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateRheemPayBills
   
   Description:  Updates a record In table 'RheemPayBills'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/20/2010 12:06:31 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateRheemPayBills
(
	@RheemPayBillsID uniqueidentifier, 
	@BrandID uniqueidentifier, 
	@Name varchar(50), 
	@Company varchar(50), 
	@Address varchar(50), 
	@City varchar(50), 
	@PostalCode varchar(50), 
	@PhoneNumber varchar(50), 
	@EmailAddress varchar(50), 
	@SerialNumber varchar(50), 
	@ModelNumber varchar(50), 
	@Wholesaler varchar(50), 
	@RequestDate datetime, 
	@Promotion varchar(50), 
	@MoreInfo int

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [RheemPayBills]
	SET
	[RheemPayBillsID] = @RheemPayBillsID, 
	[BrandID] = @BrandID, 
	[Name] = @Name, 
	[Company] = @Company, 
	[Address] = @Address, 
	[City] = @City, 
	[PostalCode] = @PostalCode, 
	[PhoneNumber] = @PhoneNumber, 
	[EmailAddress] = @EmailAddress, 
	[SerialNumber] = @SerialNumber, 
	[ModelNumber] = @ModelNumber, 
	[Wholesaler] = @Wholesaler, 
	[RequestDate] = @RequestDate, 
	[Promotion] = @Promotion, 
	[MoreInfo] = @MoreInfo

	WHERE [RheemPayBillsID] = @RheemPayBillsID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateRheemPayBills Succeeded'
Else PRINT 'Procedure Creation: UpdateRheemPayBills Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteRheemPayBills') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteRheemPayBills;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteRheemPayBills
   
   Description:  Deletes a record from table 'RheemPayBills'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/20/2010 12:06:31 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteRheemPayBills
(
	@RheemPayBillsID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [RheemPayBills] 
	WHERE [RheemPayBillsID] = @RheemPayBillsID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteRheemPayBills Succeeded'
Else PRINT 'Procedure Creation: DeleteRheemPayBills Error on Creation'
GO
		
		


