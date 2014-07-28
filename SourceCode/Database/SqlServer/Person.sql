


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'Person'
   
   AUTHOR:       Brian White - 9/21/2010 11:19:28 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertPerson') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertPerson;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertPerson
   
   Description:  Inserts a record into table 'Person'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:19:28 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertPerson
(
	@PersonID uniqueidentifier = null output,
	@UserID varchar(50) = null, 
	@FirstName varchar(50) = null, 
	@MiddleName varchar(50) = null, 
	@LastName varchar(50) = null, 
	@EmailAddress varchar(50) = null, 
	@Title varchar(50) = null, 
	@Phone varchar(50) = null, 
	@Fax varchar(50) = null, 
	@MobilePhone varchar(50) = null, 
	@ImageID uniqueidentifier, 
	@CreatedDate datetime, 
	@TerminatedDate datetime, 
	@VaultID varchar(10) = null, 
	@Username varchar(50) = null, 
	@EncryptedPassword varchar(50) = null, 
	@PasswordSeed varchar(50) = null, 
	@PasswordDate datetime, 
	@HubID varchar(100) = null, 
	@NealVaultImport datetime, 
	@VaultPassword varchar(50) = null, 
	@Disabled bit, 
	@Template bit, 
	@ManagerPersonID uniqueidentifier, 
	@PrimaryAddressID uniqueidentifier, 
	@PrimaryOrganizationID uniqueidentifier, 
	@SignatureDocumentID uniqueidentifier, 
	@TreeUpdated datetime, 
	@WelcomeEmailSent datetime, 
	@AccountUpdated datetime, 
	@ByPassDAC bit
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @PersonID = NewID()
	

	INSERT
	INTO [Person]
	(
		[PersonID], 
		[UserID], 
		[FirstName], 
		[MiddleName], 
		[LastName], 
		[EmailAddress], 
		[Title], 
		[Phone], 
		[Fax], 
		[MobilePhone], 
		[ImageID], 
		[CreatedDate], 
		[TerminatedDate], 
		[VaultID], 
		[Username], 
		[EncryptedPassword], 
		[PasswordSeed], 
		[PasswordDate], 
		[HubID], 
		[NealVaultImport], 
		[VaultPassword], 
		[Disabled], 
		[Template], 
		[ManagerPersonID], 
		[PrimaryAddressID], 
		[PrimaryOrganizationID], 
		[SignatureDocumentID], 
		[TreeUpdated], 
		[WelcomeEmailSent], 
		[AccountUpdated], 
		[ByPassDAC]
	)
	VALUES
	(
		@PersonID, 
		@UserID, 
		@FirstName, 
		@MiddleName, 
		@LastName, 
		@EmailAddress, 
		@Title, 
		@Phone, 
		@Fax, 
		@MobilePhone, 
		@ImageID, 
		@CreatedDate, 
		@TerminatedDate, 
		@VaultID, 
		@Username, 
		@EncryptedPassword, 
		@PasswordSeed, 
		@PasswordDate, 
		@HubID, 
		@NealVaultImport, 
		@VaultPassword, 
		@Disabled, 
		@Template, 
		@ManagerPersonID, 
		@PrimaryAddressID, 
		@PrimaryOrganizationID, 
		@SignatureDocumentID, 
		@TreeUpdated, 
		@WelcomeEmailSent, 
		@AccountUpdated, 
		@ByPassDAC

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertPerson Succeeded'
Else PRINT 'Procedure Creation: InsertPerson Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetPersonByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetPersonByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetPersonByID
   
   Description:  Selects record(s) from table 'Person'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:19:28 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetPersonByID
(
	@PersonID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[PersonID], [UserID], [FirstName], [MiddleName], [LastName], [EmailAddress], [Title], [Phone], [Fax], [MobilePhone], [ImageID], [CreatedDate], [TerminatedDate], [VaultID], [Username], [EncryptedPassword], [PasswordSeed], [PasswordDate], [HubID], [NealVaultImport], [VaultPassword], [Disabled], [Template], [ManagerPersonID], [PrimaryAddressID], [PrimaryOrganizationID], [SignatureDocumentID], [TreeUpdated], [WelcomeEmailSent], [AccountUpdated], [ByPassDAC]
	FROM [Person]
	WHERE [PersonID] = @PersonID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetPersonByID Succeeded'
Else PRINT 'Procedure Creation: GetPersonByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchPersonByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchPersonByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchPersonByString
   
   Description:  Selects a record from table 'Person'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:19:28 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchPersonByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[PersonID], [UserID], [FirstName], [MiddleName], [LastName], [EmailAddress], [Title], [Phone], [Fax], [MobilePhone], [ImageID], [CreatedDate], [TerminatedDate], [VaultID], [Username], [EncryptedPassword], [PasswordSeed], [PasswordDate], [HubID], [NealVaultImport], [VaultPassword], [Disabled], [Template], [ManagerPersonID], [PrimaryAddressID], [PrimaryOrganizationID], [SignatureDocumentID], [TreeUpdated], [WelcomeEmailSent], [AccountUpdated], [ByPassDAC]
	FROM [Person]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchPersonByString Succeeded'
Else PRINT 'Procedure Creation: SearchPersonByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdatePerson') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdatePerson;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdatePerson
   
   Description:  Updates a record In table 'Person'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:19:28 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdatePerson
(
	@PersonID uniqueidentifier, 
	@UserID varchar(50), 
	@FirstName varchar(50), 
	@MiddleName varchar(50), 
	@LastName varchar(50), 
	@EmailAddress varchar(50), 
	@Title varchar(50), 
	@Phone varchar(50), 
	@Fax varchar(50), 
	@MobilePhone varchar(50), 
	@ImageID uniqueidentifier, 
	@CreatedDate datetime, 
	@TerminatedDate datetime, 
	@VaultID varchar(10), 
	@Username varchar(50), 
	@EncryptedPassword varchar(50), 
	@PasswordSeed varchar(50), 
	@PasswordDate datetime, 
	@HubID varchar(100), 
	@NealVaultImport datetime, 
	@VaultPassword varchar(50), 
	@Disabled bit, 
	@Template bit, 
	@ManagerPersonID uniqueidentifier, 
	@PrimaryAddressID uniqueidentifier, 
	@PrimaryOrganizationID uniqueidentifier, 
	@SignatureDocumentID uniqueidentifier, 
	@TreeUpdated datetime, 
	@WelcomeEmailSent datetime, 
	@AccountUpdated datetime, 
	@ByPassDAC bit

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [Person]
	SET
	[PersonID] = @PersonID, 
	[UserID] = @UserID, 
	[FirstName] = @FirstName, 
	[MiddleName] = @MiddleName, 
	[LastName] = @LastName, 
	[EmailAddress] = @EmailAddress, 
	[Title] = @Title, 
	[Phone] = @Phone, 
	[Fax] = @Fax, 
	[MobilePhone] = @MobilePhone, 
	[ImageID] = @ImageID, 
	[CreatedDate] = @CreatedDate, 
	[TerminatedDate] = @TerminatedDate, 
	[VaultID] = @VaultID, 
	[Username] = @Username, 
	[EncryptedPassword] = @EncryptedPassword, 
	[PasswordSeed] = @PasswordSeed, 
	[PasswordDate] = @PasswordDate, 
	[HubID] = @HubID, 
	[NealVaultImport] = @NealVaultImport, 
	[VaultPassword] = @VaultPassword, 
	[Disabled] = @Disabled, 
	[Template] = @Template, 
	[ManagerPersonID] = @ManagerPersonID, 
	[PrimaryAddressID] = @PrimaryAddressID, 
	[PrimaryOrganizationID] = @PrimaryOrganizationID, 
	[SignatureDocumentID] = @SignatureDocumentID, 
	[TreeUpdated] = @TreeUpdated, 
	[WelcomeEmailSent] = @WelcomeEmailSent, 
	[AccountUpdated] = @AccountUpdated, 
	[ByPassDAC] = @ByPassDAC

	WHERE [PersonID] = @PersonID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdatePerson Succeeded'
Else PRINT 'Procedure Creation: UpdatePerson Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeletePerson') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeletePerson;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeletePerson
   
   Description:  Deletes a record from table 'Person'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:19:28 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeletePerson
(
	@PersonID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [Person] 
	WHERE [PersonID] = @PersonID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeletePerson Succeeded'
Else PRINT 'Procedure Creation: DeletePerson Error on Creation'
GO
		
		


