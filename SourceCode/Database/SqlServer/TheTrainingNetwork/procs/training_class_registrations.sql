USE [TheTrainingNetwork]
GO


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'training_class_registrations'
   
   AUTHOR:       Mike Harvey - 1/10/2011 4:20:35 PM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('Inserttraining_class_registrations') AND sysstat & 0xf = 4)
     DROP PROCEDURE Inserttraining_class_registrations;
GO

/* ------------------------------------------------------------
   PROCEDURE:    Inserttraining_class_registrations
   
   Description:  Inserts a record into table 'training_class_registrations'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 1/10/2011 4:20:35 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE Inserttraining_class_registrations
(
    @RegistrationID bigint = null output,
    @ClassID int, 
    @Attended int, 
    @AttendedLicenseNum varchar(16) = null, 
    @AttendName varchar(50) = null, 
    @AttendCompany varchar(50) = null, 
    @AttendPhone varchar(20) = null, 
    @AttendEMail varchar(70) = null, 
    @AttendPosition varchar(50) = null, 
    @AttendedLicenseType varchar(50) = null, 
    @CertPrinted bit
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int
    

    INSERT
    INTO [training_class_registrations]
    (
        [ClassID], 
        [Attended], 
        [AttendedLicenseNum], 
        [AttendName], 
        [AttendCompany], 
        [AttendPhone], 
        [AttendEMail], 
        [AttendPosition], 
        [AttendedLicenseType], 
        [CertPrinted]
    )
    VALUES
    (
        @ClassID, 
        @Attended, 
        @AttendedLicenseNum, 
        @AttendName, 
        @AttendCompany, 
        @AttendPhone, 
        @AttendEMail, 
        @AttendPosition, 
        @AttendedLicenseType, 
        @CertPrinted

    )

    SET @Err = @@Error
    SET @RegistrationID = @@identity


    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: Inserttraining_class_registrations Succeeded'
Else PRINT 'Procedure Creation: Inserttraining_class_registrations Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('Gettraining_class_registrationsByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE Gettraining_class_registrationsByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    Gettraining_class_registrationsByID
   
   Description:  Selects record(s) from table 'training_class_registrations'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 1/10/2011 4:20:35 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE Gettraining_class_registrationsByID
(
    @RegistrationID bigint

)
As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int

    Select 	[RegistrationID], [ClassID], [Attended], [AttendedLicenseNum], [AttendName], [AttendCompany], [AttendPhone], [AttendEMail], [AttendPosition], [AttendedLicenseType], [CertPrinted]
    FROM [training_class_registrations]
    WHERE [RegistrationID] = @RegistrationID

    Set @Err = @@Error

    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: Gettraining_class_registrationsByID Succeeded'
Else PRINT 'Procedure Creation: Gettraining_class_registrationsByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('Searchtraining_class_registrationsByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE Searchtraining_class_registrationsByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    Searchtraining_class_registrationsByString
   
   Description:  Selects a record from table 'training_class_registrations'
                 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 1/10/2011 4:20:35 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE Searchtraining_class_registrationsByString
(
    @searchParam varchar(500)
)
As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int
    DECLARE @strSql varchar(4000)
    
    SET @strSql = '	Select 	[RegistrationID], [ClassID], [Attended], [AttendedLicenseNum], [AttendName], [AttendCompany], [AttendPhone], [AttendEMail], [AttendPosition], [AttendedLicenseType], [CertPrinted]
    FROM [training_class_registrations]
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
If @@Error = 0 PRINT 'Procedure Creation: Searchtraining_class_registrationsByString Succeeded'
Else PRINT 'Procedure Creation: Searchtraining_class_registrationsByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('Updatetraining_class_registrations') AND sysstat & 0xf = 4)
     DROP PROCEDURE Updatetraining_class_registrations;
GO

/* ------------------------------------------------------------
   PROCEDURE:    Updatetraining_class_registrations
   
   Description:  Updates a record In table 'training_class_registrations'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 1/10/2011 4:20:35 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE Updatetraining_class_registrations
(
    @RegistrationID bigint, 
    @ClassID int, 
    @Attended int, 
    @AttendedLicenseNum varchar(16), 
    @AttendName varchar(50), 
    @AttendCompany varchar(50), 
    @AttendPhone varchar(20), 
    @AttendEMail varchar(70), 
    @AttendPosition varchar(50), 
    @AttendedLicenseType varchar(50), 
    @CertPrinted bit

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int

    UPDATE [training_class_registrations]
    SET
    [ClassID] = @ClassID, 
    [Attended] = @Attended, 
    [AttendedLicenseNum] = @AttendedLicenseNum, 
    [AttendName] = @AttendName, 
    [AttendCompany] = @AttendCompany, 
    [AttendPhone] = @AttendPhone, 
    [AttendEMail] = @AttendEMail, 
    [AttendPosition] = @AttendPosition, 
    [AttendedLicenseType] = @AttendedLicenseType, 
    [CertPrinted] = @CertPrinted

    WHERE [RegistrationID] = @RegistrationID

    Set @Err = @@Error

    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: Updatetraining_class_registrations Succeeded'
Else PRINT 'Procedure Creation: Updatetraining_class_registrations Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('Deletetraining_class_registrations') AND sysstat & 0xf = 4)
     DROP PROCEDURE Deletetraining_class_registrations;
GO

/* ------------------------------------------------------------
   PROCEDURE:    Deletetraining_class_registrations
   
   Description:  Deletes a record from table 'training_class_registrations'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 1/10/2011 4:20:35 PM
   ------------------------------------------------------------ */

CREATE PROCEDURE Deletetraining_class_registrations
(
    @RegistrationID bigint

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int

    DELETE FROM [training_class_registrations] 
    WHERE [RegistrationID] = @RegistrationID
        

    Set @Err = @@Error

    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: Deletetraining_class_registrations Succeeded'
Else PRINT 'Procedure Creation: Deletetraining_class_registrations Error on Creation'
GO
        
        
