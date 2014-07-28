


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'specialPages'
   
   AUTHOR:       Brian White - 10/27/2010 12:14:18 PM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertspecialPages') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertspecialPages;
	 PRINT 'Dropped InsertspecialPages'
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertspecialPages
   
   Description:  Inserts a record into table 'specialPages'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 12:14:18 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertspecialPages
(
	@specialPageID int = null output,
	@pageContent text = null, 
	@pageTitle varchar(250) = null, 
	@entryDate datetime, 
	@entryPersonID uniqueidentifier
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	

	INSERT
	INTO [specialPages]
	(
		[pageContent], 
		[pageTitle], 
		[entryDate], 
		[entryPersonID]
	)
	VALUES
	(
		@pageContent, 
		@pageTitle, 
		@entryDate, 
		@entryPersonID

	)

	SET @Err = @@Error
	SET @specialPageID = @@identity


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertspecialPages Succeeded'
Else PRINT 'Procedure Creation: InsertspecialPages Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetspecialPagesByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetspecialPagesByID;
	 PRINT 'Dropped GetspecialPagesByID'
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetspecialPagesByID
   
   Description:  Selects record(s) from table 'specialPages'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 12:14:18 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetspecialPagesByID
(
	@specialPageID int

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[specialPageID], [pageContent], [pageTitle], [entryDate], [entryPersonID]
	FROM [specialPages]
	WHERE [specialPageID] = @specialPageID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetspecialPagesByID Succeeded'
Else PRINT 'Procedure Creation: GetspecialPagesByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchspecialPagesByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchspecialPagesByString;
	 PRINT 'Dropped SearchspecialPagesByString'
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchspecialPagesByString
   
   Description:  Selects a record from table 'specialPages'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 12:14:18 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchspecialPagesByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[specialPageID], [pageContent], [pageTitle], [entryDate], [entryPersonID]
	FROM [specialPages]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchspecialPagesByString Succeeded'
Else PRINT 'Procedure Creation: SearchspecialPagesByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdatespecialPages') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdatespecialPages;
	 PRINT 'Dropped UpdatespecialPages'
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdatespecialPages
   
   Description:  Updates a record In table 'specialPages'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 12:14:18 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdatespecialPages
(
	@specialPageID int, 
	@pageContent text, 
	@pageTitle varchar(250), 
	@entryDate datetime, 
	@entryPersonID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [specialPages]
	SET
	[pageContent] = @pageContent, 
	[pageTitle] = @pageTitle, 
	[entryDate] = @entryDate, 
	[entryPersonID] = @entryPersonID

	WHERE [specialPageID] = @specialPageID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdatespecialPages Succeeded'
Else PRINT 'Procedure Creation: UpdatespecialPages Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeletespecialPages') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeletespecialPages;
	 PRINT 'Dropped DeletespecialPages'
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeletespecialPages
   
   Description:  Deletes a record from table 'specialPages'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 12:14:18 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeletespecialPages
(
	@specialPageID int

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [specialPages] 
	WHERE [specialPageID] = @specialPageID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeletespecialPages Succeeded'
Else PRINT 'Procedure Creation: DeletespecialPages Error on Creation'
GO
		
		


