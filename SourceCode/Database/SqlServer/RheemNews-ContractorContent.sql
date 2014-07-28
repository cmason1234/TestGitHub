


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'contractorContent'
   
   AUTHOR:       Brian White - 10/27/2010 7:52:06 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertcontractorContent') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertcontractorContent;
	 PRINT 'Dropped InsertcontractorContent'
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertcontractorContent
   
   Description:  Inserts a record into table 'contractorContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 7:52:06 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertcontractorContent
(
	@contractorContentID int = null output,
	@pageTitle varchar(250) = null, 
	@pageContent text = null, 
	@brand varchar(50) = null, 
	@category varchar(50) = null
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	

	INSERT
	INTO [contractorContent]
	(
		[pageTitle], 
		[pageContent], 
		[brand], 
		[category]
	)
	VALUES
	(
		@pageTitle, 
		@pageContent, 
		@brand, 
		@category

	)

	SET @Err = @@Error
	SET @contractorContentID = @@identity


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertcontractorContent Succeeded'
Else PRINT 'Procedure Creation: InsertcontractorContent Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetcontractorContentByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetcontractorContentByID;
	 PRINT 'Dropped GetcontractorContentByID'
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetcontractorContentByID
   
   Description:  Selects record(s) from table 'contractorContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 7:52:06 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetcontractorContentByID
(
	@contractorContentID int

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[contractorContentID], [pageTitle], [pageContent], [brand], [category]
	FROM [contractorContent]
	WHERE [contractorContentID] = @contractorContentID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetcontractorContentByID Succeeded'
Else PRINT 'Procedure Creation: GetcontractorContentByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchcontractorContentByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchcontractorContentByString;
	 PRINT 'Dropped SearchcontractorContentByString'
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchcontractorContentByString
   
   Description:  Selects a record from table 'contractorContent'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 7:52:06 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchcontractorContentByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[contractorContentID], [pageTitle], [pageContent], [brand], [category]
	FROM [contractorContent]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchcontractorContentByString Succeeded'
Else PRINT 'Procedure Creation: SearchcontractorContentByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdatecontractorContent') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdatecontractorContent;
	 PRINT 'Dropped UpdatecontractorContent'
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdatecontractorContent
   
   Description:  Updates a record In table 'contractorContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 7:52:06 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdatecontractorContent
(
	@contractorContentID int, 
	@pageTitle varchar(250), 
	@pageContent text, 
	@brand varchar(50), 
	@category varchar(50)

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [contractorContent]
	SET
	[pageTitle] = @pageTitle, 
	[pageContent] = @pageContent, 
	[brand] = @brand, 
	[category] = @category

	WHERE [contractorContentID] = @contractorContentID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdatecontractorContent Succeeded'
Else PRINT 'Procedure Creation: UpdatecontractorContent Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeletecontractorContent') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeletecontractorContent;
	 PRINT 'Dropped DeletecontractorContent'
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeletecontractorContent
   
   Description:  Deletes a record from table 'contractorContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/27/2010 7:52:06 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeletecontractorContent
(
	@contractorContentID int

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [contractorContent] 
	WHERE [contractorContentID] = @contractorContentID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeletecontractorContent Succeeded'
Else PRINT 'Procedure Creation: DeletecontractorContent Error on Creation'
GO
		
		


