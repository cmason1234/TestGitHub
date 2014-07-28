


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'Login'
   
   AUTHOR:       Brian White - 9/21/2010 11:08:41 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertLogin') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertLogin;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertLogin
   
   Description:  Inserts a record into table 'Login'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:08:41 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertLogin
(
	@LoginID uniqueidentifier = null output,
	@Brand varchar(50) = null, 
	@AppName varchar(50) = null, 
	@PersonID uniqueidentifier, 
	@LoginDate datetime, 
	@URL varchar(250) = null
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @LoginID = NewID()
	

	INSERT
	INTO [Login]
	(
		[LoginID], 
		[Brand], 
		[AppName], 
		[PersonID], 
		[LoginDate], 
		[URL]
	)
	VALUES
	(
		@LoginID, 
		@Brand, 
		@AppName, 
		@PersonID, 
		@LoginDate, 
		@URL

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertLogin Succeeded'
Else PRINT 'Procedure Creation: InsertLogin Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetLoginByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetLoginByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetLoginByID
   
   Description:  Selects record(s) from table 'Login'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:08:41 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetLoginByID
(
	@LoginID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[LoginID], [Brand], [AppName], [PersonID], [LoginDate], [URL]
	FROM [Login]
	WHERE [LoginID] = @LoginID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetLoginByID Succeeded'
Else PRINT 'Procedure Creation: GetLoginByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchLoginByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchLoginByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchLoginByString
   
   Description:  Selects a record from table 'Login'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:08:41 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchLoginByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[LoginID], [Brand], [AppName], [PersonID], [LoginDate], [URL]
	FROM [Login]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchLoginByString Succeeded'
Else PRINT 'Procedure Creation: SearchLoginByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateLogin') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateLogin;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateLogin
   
   Description:  Updates a record In table 'Login'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:08:41 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateLogin
(
	@LoginID uniqueidentifier, 
	@Brand varchar(50), 
	@AppName varchar(50), 
	@PersonID uniqueidentifier, 
	@LoginDate datetime, 
	@URL varchar(250)

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [Login]
	SET
	[LoginID] = @LoginID, 
	[Brand] = @Brand, 
	[AppName] = @AppName, 
	[PersonID] = @PersonID, 
	[LoginDate] = @LoginDate, 
	[URL] = @URL

	WHERE [LoginID] = @LoginID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateLogin Succeeded'
Else PRINT 'Procedure Creation: UpdateLogin Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteLogin') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteLogin;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteLogin
   
   Description:  Deletes a record from table 'Login'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:08:41 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteLogin
(
	@LoginID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [Login] 
	WHERE [LoginID] = @LoginID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteLogin Succeeded'
Else PRINT 'Procedure Creation: DeleteLogin Error on Creation'
GO
		
		


