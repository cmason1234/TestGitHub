USE [motorsports2008]
GO


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'racingGuests2011'
   
   AUTHOR:       Brian White - 2/9/2011 10:39:52 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertracingGuests2011') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertracingGuests2011;
     PRINT 'Dropped InsertracingGuests2011'
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertracingGuests2011
   
   Description:  Inserts a record into table 'racingGuests2011'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 2/9/2011 10:39:52 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertracingGuests2011
(
    @racingGuestID int = null output,
    @racingHostPersonID uniqueidentifier, 
    @raceNumber int, 
    @firstName varchar(50) = null, 
    @lastName varchar(50) = null, 
    @GuestName varchar(250) = null, 
    @CompanyName varchar(250) = null, 
    @Address1 varchar(250) = null, 
    @Address2 varchar(250) = null, 
    @City varchar(250) = null, 
    @State varchar(50) = null, 
    @PostalCode varchar(250) = null, 
    @DealerBuilderETC varchar(250) = null, 
    @gender varchar(50) = null, 
    @shirtSize varchar(50) = null, 
    @email varchar(250) = null, 
    @affiliation varchar(250) = null, 
    @division varchar(250) = null, 
    @emergencyNumber varchar(50) = null, 
    @phoneNumber varchar(50) = null, 
    @title varchar(50) = null, 
    @brandOther varchar(50) = null, 
    @brand varchar(50) = null, 
    @mainBusiness varchar(50) = null, 
    @businessSector varchar(50) = null, 
    @annualPurchase bigint, 
    @replaced bit, 
    @CheckedIn int, 
    @HasRadio varchar(50) = null
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int
    

    INSERT
    INTO [racingGuests2011]
    (
        [racingHostPersonID], 
        [raceNumber], 
        [firstName], 
        [lastName], 
        [GuestName], 
        [CompanyName], 
        [Address1], 
        [Address2], 
        [City], 
        [State], 
        [PostalCode], 
        [DealerBuilderETC], 
        [gender], 
        [shirtSize], 
        [email], 
        [affiliation], 
        [division], 
        [emergencyNumber], 
        [phoneNumber], 
        [title], 
        [brandOther], 
        [brand], 
        [mainBusiness], 
        [businessSector], 
        [annualPurchase], 
        [replaced], 
        [CheckedIn], 
        [HasRadio]
    )
    VALUES
    (
        @racingHostPersonID, 
        @raceNumber, 
        @firstName, 
        @lastName, 
        @GuestName, 
        @CompanyName, 
        @Address1, 
        @Address2, 
        @City, 
        @State, 
        @PostalCode, 
        @DealerBuilderETC, 
        @gender, 
        @shirtSize, 
        @email, 
        @affiliation, 
        @division, 
        @emergencyNumber, 
        @phoneNumber, 
        @title, 
        @brandOther, 
        @brand, 
        @mainBusiness, 
        @businessSector, 
        @annualPurchase, 
        @replaced, 
        @CheckedIn, 
        @HasRadio

    )

    SET @Err = @@Error
    SET @racingGuestID = @@identity


    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertracingGuests2011 Succeeded'
Else PRINT 'Procedure Creation: InsertracingGuests2011 Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetracingGuests2011ByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetracingGuests2011ByID;
     PRINT 'Dropped GetracingGuests2011ByID'
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetracingGuests2011ByID
   
   Description:  Selects record(s) from table 'racingGuests2011'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 2/9/2011 10:39:53 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetracingGuests2011ByID
(
    @racingGuestID int

)
As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int

    Select 	[racingGuestID], [racingHostPersonID], [raceNumber], [firstName], [lastName], [GuestName], [CompanyName], [Address1], [Address2], [City], [State], [PostalCode], [DealerBuilderETC], [gender], [shirtSize], [email], [affiliation], [division], [emergencyNumber], [phoneNumber], [title], [brandOther], [brand], [mainBusiness], [businessSector], [annualPurchase], [replaced], [CheckedIn], [HasRadio]
    FROM [racingGuests2011]
    WHERE [racingGuestID] = @racingGuestID

    Set @Err = @@Error

    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetracingGuests2011ByID Succeeded'
Else PRINT 'Procedure Creation: GetracingGuests2011ByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchracingGuests2011ByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchracingGuests2011ByString;
     PRINT 'Dropped SearchracingGuests2011ByString'
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchracingGuests2011ByString
   
   Description:  Selects a record from table 'racingGuests2011'
                 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 2/9/2011 10:39:53 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchracingGuests2011ByString
(
    @searchParam varchar(500)
)
As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int
    DECLARE @strSql varchar(4000)
    
    SET @strSql = '	Select 	[racingGuestID], [racingHostPersonID], [raceNumber], [firstName], [lastName], [GuestName], [CompanyName], [Address1], [Address2], [City], [State], [PostalCode], [DealerBuilderETC], [gender], [shirtSize], [email], [affiliation], [division], [emergencyNumber], [phoneNumber], [title], [brandOther], [brand], [mainBusiness], [businessSector], [annualPurchase], [replaced], [CheckedIn], [HasRadio]
    FROM [racingGuests2011]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchracingGuests2011ByString Succeeded'
Else PRINT 'Procedure Creation: SearchracingGuests2011ByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateracingGuests2011') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateracingGuests2011;
     PRINT 'Dropped UpdateracingGuests2011'
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateracingGuests2011
   
   Description:  Updates a record In table 'racingGuests2011'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 2/9/2011 10:39:53 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateracingGuests2011
(
    @racingGuestID int, 
    @racingHostPersonID uniqueidentifier, 
    @raceNumber int, 
    @firstName varchar(50), 
    @lastName varchar(50), 
    @GuestName varchar(250), 
    @CompanyName varchar(250), 
    @Address1 varchar(250), 
    @Address2 varchar(250), 
    @City varchar(250), 
    @State varchar(50), 
    @PostalCode varchar(250), 
    @DealerBuilderETC varchar(250), 
    @gender varchar(50), 
    @shirtSize varchar(50), 
    @email varchar(250), 
    @affiliation varchar(250), 
    @division varchar(250), 
    @emergencyNumber varchar(50), 
    @phoneNumber varchar(50), 
    @title varchar(50), 
    @brandOther varchar(50), 
    @brand varchar(50), 
    @mainBusiness varchar(50), 
    @businessSector varchar(50), 
    @annualPurchase bigint, 
    @replaced bit, 
    @CheckedIn int, 
    @HasRadio varchar(50)

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int

    UPDATE [racingGuests2011]
    SET
    [racingHostPersonID] = @racingHostPersonID, 
    [raceNumber] = @raceNumber, 
    [firstName] = @firstName, 
    [lastName] = @lastName, 
    [GuestName] = @GuestName, 
    [CompanyName] = @CompanyName, 
    [Address1] = @Address1, 
    [Address2] = @Address2, 
    [City] = @City, 
    [State] = @State, 
    [PostalCode] = @PostalCode, 
    [DealerBuilderETC] = @DealerBuilderETC, 
    [gender] = @gender, 
    [shirtSize] = @shirtSize, 
    [email] = @email, 
    [affiliation] = @affiliation, 
    [division] = @division, 
    [emergencyNumber] = @emergencyNumber, 
    [phoneNumber] = @phoneNumber, 
    [title] = @title, 
    [brandOther] = @brandOther, 
    [brand] = @brand, 
    [mainBusiness] = @mainBusiness, 
    [businessSector] = @businessSector, 
    [annualPurchase] = @annualPurchase, 
    [replaced] = @replaced, 
    [CheckedIn] = @CheckedIn, 
    [HasRadio] = @HasRadio

    WHERE [racingGuestID] = @racingGuestID

    Set @Err = @@Error

    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateracingGuests2011 Succeeded'
Else PRINT 'Procedure Creation: UpdateracingGuests2011 Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteracingGuests2011') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteracingGuests2011;
     PRINT 'Dropped DeleteracingGuests2011'
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteracingGuests2011
   
   Description:  Deletes a record from table 'racingGuests2011'
   
   AUTHOR:       Rheem Manufacturing, Brian White - 2/9/2011 10:39:53 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteracingGuests2011
(
    @racingGuestID int

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int

    DELETE FROM [racingGuests2011] 
    WHERE [racingGuestID] = @racingGuestID
        

    Set @Err = @@Error

    RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteracingGuests2011 Succeeded'
Else PRINT 'Procedure Creation: DeleteracingGuests2011 Error on Creation'
GO
        
        


