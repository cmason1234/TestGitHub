USE [TheTrainingNetwork]
GO


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'training_classes'
   
   AUTHOR:       Mike Harvey - 1/10/2011 4:20:35 PM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('Inserttraining_classes') AND sysstat & 0xf = 4)
     DROP PROCEDURE Inserttraining_classes;
GO

/* ------------------------------------------------------------
   PROCEDURE:    Inserttraining_classes
   
   Description:  Inserts a record into table 'training_classes'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 1/10/2011 4:20:35 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE Inserttraining_classes
(
    @ClassID int = null output,
    @Status tinyint, 
    @InstructorID uniqueidentifier, 
    @ContactID uniqueidentifier, 
    @ClassType smallint, 
    @ClassDate datetime, 
    @ClassLength decimal, 
    @LocationName varchar(50) = null, 
    @LocationStreet varchar(50) = null, 
    @LocationStreet2 varchar(30) = null, 
    @LocationCity varchar(50) = null, 
    @LocationState char(2) = null, 
    @LocationZip varchar(10) = null, 
    @Sponsor varchar(50) = null, 
    @SponsorID uniqueidentifier, 
    @ContactPhone varchar(20) = null, 
    @ContactEMail varchar(70) = null, 
    @ClassAddlInfo varchar(255) = null, 
    @SchedulerID uniqueidentifier, 
    @SchedulerName varchar(50) = null, 
    @ReminderSent bit, 
    @Brand int, 
    @AttendanceFinalized bit
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int
    

    INSERT
    INTO [training_classes]
    (
        [Status], 
        [InstructorID], 
        [ContactID], 
        [ClassType], 
        [ClassDate], 
        [ClassLength], 
        [LocationName], 
        [LocationStreet], 
        [LocationStreet2], 
        [LocationCity], 
        [LocationState], 
        [LocationZip], 
        [Sponsor], 
        [SponsorID], 
        [ContactPhone], 
        [ContactEMail], 
        [ClassAddlInfo], 
        [SchedulerID], 
        [SchedulerName], 
        [ReminderSent], 
        [Brand], 
        [AttendanceFinalized]
    )
    VALUES
    (
        @Status, 
        @InstructorID, 
        @ContactID, 
        @ClassType, 
        @ClassDate, 
        @ClassLength, 
        @LocationName, 
        @LocationStreet, 
        @LocationStreet2, 
        @LocationCity, 
        @LocationState, 
        @LocationZip, 
        @Sponsor, 
        @SponsorID, 
        @ContactPhone, 
        @ContactEMail, 
        @ClassAddlInfo, 
        @SchedulerID, 
        @SchedulerName, 
        @ReminderSent, 
        @Brand, 
        @AttendanceFinalized

    )

    SET @Err = @@Error
    SET @ClassID = @@identity


    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: Inserttraining_classes Succeeded'
Else PRINT 'Procedure Creation: Inserttraining_classes Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('Gettraining_classesByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE Gettraining_classesByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    Gettraining_classesByID
   
   Description:  Selects record(s) from table 'training_classes'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 1/10/2011 4:20:35 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE Gettraining_classesByID
(
    @ClassID int

)
As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int

    Select 	[ClassID], [Status], [InstructorID], [ContactID], [ClassType], [ClassDate], [ClassLength], [LocationName], [LocationStreet], [LocationStreet2], [LocationCity], [LocationState], [LocationZip], [Sponsor], [SponsorID], [ContactPhone], [ContactEMail], [ClassAddlInfo], [SchedulerID], [SchedulerName], [ReminderSent], [Brand], [AttendanceFinalized]
    FROM [training_classes]
    WHERE [ClassID] = @ClassID

    Set @Err = @@Error

    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: Gettraining_classesByID Succeeded'
Else PRINT 'Procedure Creation: Gettraining_classesByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('Searchtraining_classesByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE Searchtraining_classesByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    Searchtraining_classesByString
   
   Description:  Selects a record from table 'training_classes'
                 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 1/10/2011 4:20:35 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE Searchtraining_classesByString
(
    @searchParam varchar(500)
)
As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int
    DECLARE @strSql varchar(4000)
    
    SET @strSql = '	Select 	[ClassID], [Status], [InstructorID], [ContactID], [ClassType], [ClassDate], [ClassLength], [LocationName], [LocationStreet], [LocationStreet2], [LocationCity], [LocationState], [LocationZip], [Sponsor], [SponsorID], [ContactPhone], [ContactEMail], [ClassAddlInfo], [SchedulerID], [SchedulerName], [ReminderSent], [Brand], [AttendanceFinalized]
    FROM [training_classes]
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
If @@Error = 0 PRINT 'Procedure Creation: Searchtraining_classesByString Succeeded'
Else PRINT 'Procedure Creation: Searchtraining_classesByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('Updatetraining_classes') AND sysstat & 0xf = 4)
     DROP PROCEDURE Updatetraining_classes;
GO

/* ------------------------------------------------------------
   PROCEDURE:    Updatetraining_classes
   
   Description:  Updates a record In table 'training_classes'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 1/10/2011 4:20:35 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE Updatetraining_classes
(
    @ClassID int, 
    @Status tinyint, 
    @InstructorID uniqueidentifier, 
    @ContactID uniqueidentifier, 
    @ClassType smallint, 
    @ClassDate datetime, 
    @ClassLength decimal, 
    @LocationName varchar(50), 
    @LocationStreet varchar(50), 
    @LocationStreet2 varchar(30), 
    @LocationCity varchar(50), 
    @LocationState char(2), 
    @LocationZip varchar(10), 
    @Sponsor varchar(50), 
    @SponsorID uniqueidentifier, 
    @ContactPhone varchar(20), 
    @ContactEMail varchar(70), 
    @ClassAddlInfo varchar(255), 
    @SchedulerID uniqueidentifier, 
    @SchedulerName varchar(50), 
    @ReminderSent bit, 
    @Brand int, 
    @AttendanceFinalized bit

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int

    UPDATE [training_classes]
    SET
    [Status] = @Status, 
    [InstructorID] = @InstructorID, 
    [ContactID] = @ContactID, 
    [ClassType] = @ClassType, 
    [ClassDate] = @ClassDate, 
    [ClassLength] = @ClassLength, 
    [LocationName] = @LocationName, 
    [LocationStreet] = @LocationStreet, 
    [LocationStreet2] = @LocationStreet2, 
    [LocationCity] = @LocationCity, 
    [LocationState] = @LocationState, 
    [LocationZip] = @LocationZip, 
    [Sponsor] = @Sponsor, 
    [SponsorID] = @SponsorID, 
    [ContactPhone] = @ContactPhone, 
    [ContactEMail] = @ContactEMail, 
    [ClassAddlInfo] = @ClassAddlInfo, 
    [SchedulerID] = @SchedulerID, 
    [SchedulerName] = @SchedulerName, 
    [ReminderSent] = @ReminderSent, 
    [Brand] = @Brand, 
    [AttendanceFinalized] = @AttendanceFinalized

    WHERE [ClassID] = @ClassID

    Set @Err = @@Error

    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: Updatetraining_classes Succeeded'
Else PRINT 'Procedure Creation: Updatetraining_classes Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('Deletetraining_classes') AND sysstat & 0xf = 4)
     DROP PROCEDURE Deletetraining_classes;
GO

/* ------------------------------------------------------------
   PROCEDURE:    Deletetraining_classes
   
   Description:  Deletes a record from table 'training_classes'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 1/10/2011 4:20:35 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE Deletetraining_classes
(
    @ClassID int

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int

    DELETE FROM [training_classes] 
    WHERE [ClassID] = @ClassID
        

    Set @Err = @@Error

    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: Deletetraining_classes Succeeded'
Else PRINT 'Procedure Creation: Deletetraining_classes Error on Creation'
GO
        
        
