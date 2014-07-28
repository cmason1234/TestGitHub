


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'topContent'
   
   AUTHOR:       Brian White - 10/26/2010 11:07:58 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InserttopContent') AND sysstat & 0xf = 4)
     DROP PROCEDURE InserttopContent;
	 PRINT 'Dropped InserttopContent'
GO

/* ------------------------------------------------------------
   PROCEDURE:    InserttopContent
   
   Description:  Inserts a record into table 'topContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/26/2010 11:07:58 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InserttopContent
(
	@topContentID int = null output,
	@pageTitle varchar(250) = null, 
	@linkTitle varchar(50) = null, 
	@pageContent text = null, 
	@brand varchar(50) = null
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	

	INSERT
	INTO [topContent]
	(
		[pageTitle], 
		[linkTitle], 
		[pageContent], 
		[brand]
	)
	VALUES
	(
		@pageTitle, 
		@linkTitle, 
		@pageContent, 
		@brand

	)

	SET @Err = @@Error
	SET @topContentID = @@identity


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InserttopContent Succeeded'
Else PRINT 'Procedure Creation: InserttopContent Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GettopContentByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GettopContentByID;
	 PRINT 'Dropped GettopContentByID'
GO

/* ------------------------------------------------------------
   PROCEDURE:    GettopContentByID
   
   Description:  Selects record(s) from table 'topContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/26/2010 11:07:58 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GettopContentByID
(
	@topContentID int

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[topContentID], [pageTitle], [linkTitle], [pageContent], [brand]
	FROM [topContent]
	WHERE [topContentID] = @topContentID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GettopContentByID Succeeded'
Else PRINT 'Procedure Creation: GettopContentByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchtopContentByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchtopContentByString;
	 PRINT 'Dropped SearchtopContentByString'
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchtopContentByString
   
   Description:  Selects a record from table 'topContent'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/26/2010 11:07:58 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchtopContentByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[topContentID], [pageTitle], [linkTitle], [pageContent], [brand]
	FROM [topContent]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchtopContentByString Succeeded'
Else PRINT 'Procedure Creation: SearchtopContentByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdatetopContent') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdatetopContent;
	 PRINT 'Dropped UpdatetopContent'
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdatetopContent
   
   Description:  Updates a record In table 'topContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/26/2010 11:07:58 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdatetopContent
(
	@topContentID int, 
	@pageTitle varchar(250), 
	@linkTitle varchar(50), 
	@pageContent text, 
	@brand varchar(50)

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [topContent]
	SET
	[pageTitle] = @pageTitle, 
	[linkTitle] = @linkTitle, 
	[pageContent] = @pageContent, 
	[brand] = @brand

	WHERE [topContentID] = @topContentID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdatetopContent Succeeded'
Else PRINT 'Procedure Creation: UpdatetopContent Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeletetopContent') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeletetopContent;
	 PRINT 'Dropped DeletetopContent'
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeletetopContent
   
   Description:  Deletes a record from table 'topContent'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 10/26/2010 11:07:58 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeletetopContent
(
	@topContentID int

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [topContent] 
	WHERE [topContentID] = @topContentID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeletetopContent Succeeded'
Else PRINT 'Procedure Creation: DeletetopContent Error on Creation'
GO
		
		


