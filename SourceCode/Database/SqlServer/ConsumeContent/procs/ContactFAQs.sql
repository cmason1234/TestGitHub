USE [ConsumerContent]
GO

/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContactFAQs'
   
   AUTHOR:       Brian White - 12/20/2010 2:16:27 PM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContactFAQs') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContactFAQs;
     PRINT 'Dropped InsertContactFAQs'
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContactFAQs
   
   Description:  Inserts a record into table 'ContactFAQs'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 12/20/2010 2:16:27 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContactFAQs
(
    @ID uniqueidentifier = null output,
    @SubtopicID int, 
    @Title varchar(200) = null, 
    @Content varchar(max) = null, 
    @Rank int
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int
    
    SET @ID = NewID()
    

    INSERT
    INTO [ContactFAQs]
    (
        [ID], 
        [SubtopicID], 
        [Title], 
        [Content], 
        [Rank]
    )
    VALUES
    (
        @ID, 
        @SubtopicID, 
        @Title, 
        @Content, 
        @Rank

    )

    SET @Err = @@Error


    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContactFAQs Succeeded'
Else PRINT 'Procedure Creation: InsertContactFAQs Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContactFAQsByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContactFAQsByID;
     PRINT 'Dropped GetContactFAQsByID'
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContactFAQsByID
   
   Description:  Selects record(s) from table 'ContactFAQs'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 12/20/2010 2:16:27 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContactFAQsByID
(
    @ID uniqueidentifier

)
As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int

    Select 	[ID], [SubtopicID], [Title], [Content], [Rank]
    FROM [ContactFAQs]
    WHERE [ID] = @ID

    Set @Err = @@Error

    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContactFAQsByID Succeeded'
Else PRINT 'Procedure Creation: GetContactFAQsByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContactFAQsByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContactFAQsByString;
     PRINT 'Dropped SearchContactFAQsByString'
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContactFAQsByString
   
   Description:  Selects a record from table 'ContactFAQs'
                 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 12/20/2010 2:16:27 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContactFAQsByString
(
    @searchParam varchar(500)
)
As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int
    DECLARE @strSql varchar(4000)
    
    SET @strSql = '	Select 	[ID], [SubtopicID], [Title], [Content], [Rank]
    FROM [ContactFAQs]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchContactFAQsByString Succeeded'
Else PRINT 'Procedure Creation: SearchContactFAQsByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContactFAQs') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContactFAQs;
     PRINT 'Dropped UpdateContactFAQs'
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContactFAQs
   
   Description:  Updates a record In table 'ContactFAQs'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 12/20/2010 2:16:27 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContactFAQs
(
    @ID uniqueidentifier, 
    @SubtopicID int, 
    @Title varchar(200), 
    @Content varchar(max), 
    @Rank int

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int

    UPDATE [ContactFAQs]
    SET
    [ID] = @ID, 
    [SubtopicID] = @SubtopicID, 
    [Title] = @Title, 
    [Content] = @Content, 
    [Rank] = @Rank

    WHERE [ID] = @ID

    Set @Err = @@Error

    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContactFAQs Succeeded'
Else PRINT 'Procedure Creation: UpdateContactFAQs Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContactFAQs') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContactFAQs;
     PRINT 'Dropped DeleteContactFAQs'
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContactFAQs
   
   Description:  Deletes a record from table 'ContactFAQs'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 12/20/2010 2:16:27 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContactFAQs
(
    @ID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int

    DELETE FROM [ContactFAQs] 
    WHERE [ID] = @ID
        

    Set @Err = @@Error

    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContactFAQs Succeeded'
Else PRINT 'Procedure Creation: DeleteContactFAQs Error on Creation'
GO
        
        


