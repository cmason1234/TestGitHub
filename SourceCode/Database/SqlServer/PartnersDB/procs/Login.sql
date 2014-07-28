USE [PartnersDB]
GO
/****** Object:  StoredProcedure [dbo].[SearchLoginByString]    Script Date: 01/06/2011 13:07:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    SearchLoginByString
   
   Description:  Selects a record from table 'Login'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:08:41 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchLoginByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE SearchLoginByString;
		PRINT 'Dropped SearchLoginByString'
	END
GO

CREATE PROCEDURE [dbo].[SearchLoginByString]
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
/****** Object:  StoredProcedure [dbo].[UpdateLogin]    Script Date: 01/06/2011 13:07:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    UpdateLogin
   
   Description:  Updates a record In table 'Login'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:08:41 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateLogin') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE UpdateLogin;
		PRINT 'Dropped UpdateLogin'
	END
GO

CREATE PROCEDURE [dbo].[UpdateLogin]
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
/****** Object:  StoredProcedure [dbo].[GetLoginByID]    Script Date: 01/06/2011 13:07:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    GetLoginByID
   
   Description:  Selects record(s) from table 'Login'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:08:41 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetLoginByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE GetLoginByID;
		PRINT 'Dropped GetLoginByID'
	END
GO

CREATE PROCEDURE [dbo].[GetLoginByID]
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
/****** Object:  StoredProcedure [dbo].[DeleteLogin]    Script Date: 01/06/2011 13:07:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    DeleteLogin
   
   Description:  Deletes a record from table 'Login'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:08:41 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteLogin') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE DeleteLogin;
		PRINT 'Dropped DeleteLogin'
	END
GO

CREATE PROCEDURE [dbo].[DeleteLogin]
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
/****** Object:  StoredProcedure [dbo].[InsertLogin]    Script Date: 01/06/2011 13:07:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* ------------------------------------------------------------
   PROCEDURE:    InsertLogin
   
   Description:  Inserts a record into table 'Login'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/21/2010 11:08:41 AM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertLogin') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
	BEGIN
		DROP PROCEDURE InsertLogin;
		PRINT 'Dropped InsertLogin'
	END
GO

CREATE PROCEDURE [dbo].[InsertLogin]
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
	INTO snarkpub_user.Login
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
