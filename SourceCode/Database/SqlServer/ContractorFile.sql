


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContractorFile'
   
   AUTHOR:       Mike Harvey - 11/2/2010 2:08:13 PM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorFile') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContractorFile;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContractorFile
   
   Description:  Inserts a record into table 'ContractorFile'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/2/2010 2:08:13 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContractorFile
(
	@ContractorFileID uniqueidentifier = null output,
	@ObjectID uniqueidentifier, 
	@Filename varchar(256) = null, 
	@Mimetype varchar(256) = null, 
	@ByteCount int, 
	@CreationDate datetime, 
	@DocumentSrc image, 
	@Description varchar(256) = null
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @ContractorFileID = NewID()
	

	INSERT
	INTO [ContractorFile]
	(
		[ContractorFileID], 
		[ObjectID], 
		[Filename], 
		[Mimetype], 
		[ByteCount], 
		[CreationDate], 
		[DocumentSrc], 
		[Description]
	)
	VALUES
	(
		@ContractorFileID, 
		@ObjectID, 
		@Filename, 
		@Mimetype, 
		@ByteCount, 
		@CreationDate, 
		@DocumentSrc, 
		@Description

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContractorFile Succeeded'
Else PRINT 'Procedure Creation: InsertContractorFile Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorFileByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContractorFileByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContractorFileByID
   
   Description:  Selects record(s) from table 'ContractorFile'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/2/2010 2:08:13 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContractorFileByID
(
	@ContractorFileID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[ContractorFileID], [ObjectID], [Filename], [Mimetype], [ByteCount], [CreationDate], [DocumentSrc], [Description]
	FROM [ContractorFile]
	WHERE [ContractorFileID] = @ContractorFileID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContractorFileByID Succeeded'
Else PRINT 'Procedure Creation: GetContractorFileByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorFileByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContractorFileByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContractorFileByString
   
   Description:  Selects a record from table 'ContractorFile'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/2/2010 2:08:13 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContractorFileByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[ContractorFileID], [ObjectID], [Filename], [Mimetype], [ByteCount], [CreationDate], [DocumentSrc], [Description]
	FROM [ContractorFile]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchContractorFileByString Succeeded'
Else PRINT 'Procedure Creation: SearchContractorFileByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorFile') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContractorFile;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContractorFile
   
   Description:  Updates a record In table 'ContractorFile'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/2/2010 2:08:13 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContractorFile
(
	@ContractorFileID uniqueidentifier, 
	@ObjectID uniqueidentifier, 
	@Filename varchar(256), 
	@Mimetype varchar(256), 
	@ByteCount int, 
	@CreationDate datetime, 
	@DocumentSrc image, 
	@Description varchar(256)

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContractorFile]
	SET
	[ContractorFileID] = @ContractorFileID, 
	[ObjectID] = @ObjectID, 
	[Filename] = @Filename, 
	[Mimetype] = @Mimetype, 
	[ByteCount] = @ByteCount, 
	[CreationDate] = @CreationDate, 
	[DocumentSrc] = @DocumentSrc, 
	[Description] = @Description

	WHERE [ContractorFileID] = @ContractorFileID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContractorFile Succeeded'
Else PRINT 'Procedure Creation: UpdateContractorFile Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorFile') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContractorFile;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorFile
   
   Description:  Deletes a record from table 'ContractorFile'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/2/2010 2:08:13 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContractorFile
(
	@ContractorFileID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorFile] 
	WHERE [ContractorFileID] = @ContractorFileID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContractorFile Succeeded'
Else PRINT 'Procedure Creation: DeleteContractorFile Error on Creation'
GO
		
		
