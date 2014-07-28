/*
'===============================================================================
' Generated by GenerateDataAndObjectLayer Version 1.0.0.0
'
' <auto-generated>
'     This code was generated by a tool.
'
'     Changes to this file may cause incorrect behavior and will be lost if
'     the code is regenerated. 
' </auto-generated>
'===============================================================================

*/
USE [RheemUsers]

/* ------------------------------------------------------------
   Get rid of obsolete InsertHDEquipment
   Get rid of obsolete UpdateHDEquipment
   Get rid of obsolete DeleteHDEquipment
   Get rid of obsolete SearchHDEquipmentByString
   Get rid of obsolete GetHDEquipmentByID
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertHDEquipment') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE InsertHDEquipment;
        PRINT 'Dropped InsertHDEquipment'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateHDEquipment') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE UpdateHDEquipment;
        PRINT 'Dropped UpdateHDEquipment'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteHDEquipment') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE DeleteHDEquipment;
        PRINT 'Dropped DeleteHDEquipment'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchHDEquipmentByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE SearchHDEquipmentByString;
        PRINT 'Dropped SearchHDEquipmentByString'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetHDEquipmentByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetHDEquipmentByID;
        PRINT 'Dropped GetHDEquipmentByID'
    END
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDEquipment_GetByID') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDEquipment_GetByID;
        PRINT 'Dropped spGen__HDEquipment_GetByID'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDEquipment_GetByID

   Description:  Selects record(s) from table 'HDEquipment'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDEquipment_GetByID
(
    @HDEquipmentID uniqueidentifier

)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int

    Select [HDEquipmentID],[HDQuoteID],[Manufacturer],[CHP1Model],[CHP1Serial],[CHP2Model],[CHP2Serial],[FAH1Model],[FAH1Serial],[FAH2Model],[FAH2Serial],[CoilModel],[ThermostatModel],[AirCleanerModel],[HumidifierModel],[Other1Desc],[Other1Model],[Other2Desc],[Other2Model],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [HDEquipment]
    WHERE [HDEquipmentID] = @HDEquipmentID

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDEquipment_GetByID Succeeded'
Else PRINT 'Procedure Creation: spGen__HDEquipment_GetByID Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDEquipment_SearchByString') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDEquipment_SearchByString;
        PRINT 'Dropped spGen__HDEquipment_SearchByString'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDEquipment_SearchByString

   Description:  Selects a record from table 'HDEquipment'
                 And puts values into parameters

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDEquipment_SearchByString
(
    @searchParam varchar(4000)
)

AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @Err Int
    DECLARE @strSql varchar(4000)

    SET @strSql = ' Select [HDEquipmentID],[HDQuoteID],[Manufacturer],[CHP1Model],[CHP1Serial],[CHP2Model],[CHP2Serial],[FAH1Model],[FAH1Serial],[FAH2Model],[FAH2Serial],[CoilModel],[ThermostatModel],[AirCleanerModel],[HumidifierModel],[Other1Desc],[Other1Model],[Other2Desc],[Other2Model],[CreateDateTime__Gen],[UpdateDateTime__Gen]
    FROM [HDEquipment]
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
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDEquipment_SearchByString Succeeded'
Else PRINT 'Procedure Creation: spGen__HDEquipment_SearchByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDEquipment_Delete') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDEquipment_Delete;
        PRINT 'Dropped spGen__HDEquipment_Delete'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDEquipment_Delete

   Description:  Deletes a record from table 'HDEquipment'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDEquipment_Delete
(
    @HDEquipmentID uniqueidentifier

)
AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    DECLARE @Err Int


    DELETE FROM [HDEquipment]
    WHERE [HDEquipmentID] = @HDEquipmentID


End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDEquipment_Delete Succeeded'
Else PRINT 'Procedure Creation: spGen__HDEquipment_Delete Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('spGen__HDEquipment_Save') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE spGen__HDEquipment_Save;
        PRINT 'Dropped spGen__HDEquipment_Save'
    END
GO

/* ------------------------------------------------------------
   PROCEDURE:    spGen__HDEquipment_Save

   Description:  Updates or Deletes a record In table 'HDEquipment'

   Generated by GenerateDataAndObjectLayer Version 1.0.0.0
   ------------------------------------------------------------ */

CREATE PROCEDURE dbo.spGen__HDEquipment_Save
(
    @ErrText varchar(4000) output,
    @HDEquipmentID uniqueidentifier output,
    @HDQuoteID uniqueidentifier,
    @Manufacturer varchar(50),
    @CHP1Model varchar(50),
    @CHP1Serial varchar(50),
    @CHP2Model varchar(50),
    @CHP2Serial varchar(50),
    @FAH1Model varchar(50),
    @FAH1Serial varchar(50),
    @FAH2Model varchar(50),
    @FAH2Serial varchar(50),
    @CoilModel varchar(50),
    @ThermostatModel varchar(50),
    @AirCleanerModel varchar(50),
    @HumidifierModel varchar(50),
    @Other1Desc varchar(150),
    @Other1Model varchar(50),
    @Other2Desc varchar(150),
    @Other2Model varchar(50)
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN

    DECLARE @UniqueRowCount Int
    IF @HDEquipmentID = '00000000-0000-0000-0000-000000000000' SET @HDEquipmentID = NULL
    IF @HDEquipmentID IS NULL
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    SET @HDEquipmentID = NewID()

                    INSERT
                    INTO [HDEquipment]
                    (
                        [HDEquipmentID],
                        [HDQuoteID],
                        [Manufacturer],
                        [CHP1Model],
                        [CHP1Serial],
                        [CHP2Model],
                        [CHP2Serial],
                        [FAH1Model],
                        [FAH1Serial],
                        [FAH2Model],
                        [FAH2Serial],
                        [CoilModel],
                        [ThermostatModel],
                        [AirCleanerModel],
                        [HumidifierModel],
                        [Other1Desc],
                        [Other1Model],
                        [Other2Desc],
                        [Other2Model],
                        [CreateDateTime__Gen],
                        [UpdateDateTime__Gen]
                    )
                    VALUES
                    (
                        @HDEquipmentID,
                        @HDQuoteID,
                        @Manufacturer,
                        @CHP1Model,
                        @CHP1Serial,
                        @CHP2Model,
                        @CHP2Serial,
                        @FAH1Model,
                        @FAH1Serial,
                        @FAH2Model,
                        @FAH2Serial,
                        @CoilModel,
                        @ThermostatModel,
                        @AirCleanerModel,
                        @HumidifierModel,
                        @Other1Desc,
                        @Other1Model,
                        @Other2Desc,
                        @Other2Model,
                        SYSDATETIME(),
                        SYSDATETIME()
                    )
                END
        END
    ELSE
        BEGIN
            SET @UniqueRowCount = 0       -- No unique indexes exist for this table
            IF @UniqueRowCount > 0
                BEGIN
                    SET @ErrText = ''    -- No unique indexes exist for this table
                END
            ELSE
                BEGIN
                    UPDATE [HDEquipment]
                    SET
                    [HDQuoteID] = @HDQuoteID,
                    [Manufacturer] = @Manufacturer,
                    [CHP1Model] = @CHP1Model,
                    [CHP1Serial] = @CHP1Serial,
                    [CHP2Model] = @CHP2Model,
                    [CHP2Serial] = @CHP2Serial,
                    [FAH1Model] = @FAH1Model,
                    [FAH1Serial] = @FAH1Serial,
                    [FAH2Model] = @FAH2Model,
                    [FAH2Serial] = @FAH2Serial,
                    [CoilModel] = @CoilModel,
                    [ThermostatModel] = @ThermostatModel,
                    [AirCleanerModel] = @AirCleanerModel,
                    [HumidifierModel] = @HumidifierModel,
                    [Other1Desc] = @Other1Desc,
                    [Other1Model] = @Other1Model,
                    [Other2Desc] = @Other2Desc,
                    [Other2Model] = @Other2Model,
                    [UpdateDateTime__Gen] = SYSDATETIME()
                    WHERE [HDEquipmentID] = @HDEquipmentID
                END
        END

End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: spGen__HDEquipment_Save Succeeded'
Else PRINT 'Procedure Creation: spGen__HDEquipment_Save Error on Creation'
GO




