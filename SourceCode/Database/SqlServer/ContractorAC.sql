


/* 
------------------------------------------------------------
   Description:  Common stored procedures For table 'ContractorAC'
   
   AUTHOR:       Mike Harvey - 11/1/2010 9:06:03 AM
   
   LEGAL :       Copyright 2010 - Rheem Manufacturing
------------------------------------------------------------ 
*/
   


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('InsertContractorAC') AND sysstat & 0xf = 4)
     DROP PROCEDURE InsertContractorAC;
GO

/* ------------------------------------------------------------
   PROCEDURE:    InsertContractorAC
   
   Description:  Inserts a record into table 'ContractorAC'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE InsertContractorAC
(
	@ContractorACID uniqueidentifier = null output,
	@OrganizationID uniqueidentifier, 
	@BrandID uniqueidentifier, 
	@DistributorOrganizationID uniqueidentifier, 
	@DealerNumber varchar(50) = null, 
	@Contact varchar(50) = null, 
	@HVACLicense varchar(50) = null, 
	@Disabled bit, 
	@ShowOnLocator bit, 
	@TopTen bit, 
	@Funding varchar(50) = null, 
	@Status varchar(50) = null, 
	@ActivationDate datetime, 
	@TerminationDate datetime, 
	@TerminationReason varchar(50) = null, 
	@LocatorPlacement int, 
	@DealerThemesID uniqueidentifier, 
	@DesignStar bit, 
	@DesignStarActive bit, 
	@DesignStarGizmo bit, 
	@ProtectionPlus bit, 
	@ProtectionPlusNumber varchar(50) = null, 
	@ShowNateLogo bit, 
	@Cashback bit, 
	@CashBackSpecial bit, 
	@CashBackText text = null, 
	@DesignStarManagerPersonID uniqueidentifier, 
	@ProtectionPlusEquiguard varchar(50) = null
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int
	
	SET @ContractorACID = NewID()
	

	INSERT
	INTO [ContractorAC]
	(
		[ContractorACID], 
		[OrganizationID], 
		[BrandID], 
		[DistributorOrganizationID], 
		[DealerNumber], 
		[Contact], 
		[HVACLicense], 
		[Disabled], 
		[ShowOnLocator], 
		[TopTen], 
		[Funding], 
		[Status], 
		[ActivationDate], 
		[TerminationDate], 
		[TerminationReason], 
		[LocatorPlacement], 
		[DealerThemesID], 
		[DesignStar], 
		[DesignStarActive], 
		[DesignStarGizmo], 
		[ProtectionPlus], 
		[ProtectionPlusNumber], 
		[ShowNateLogo], 
		[Cashback], 
		[CashBackSpecial], 
		[CashBackText], 
		[DesignStarManagerPersonID], 
		[ProtectionPlusEquiguard]
	)
	VALUES
	(
		@ContractorACID, 
		@OrganizationID, 
		@BrandID, 
		@DistributorOrganizationID, 
		@DealerNumber, 
		@Contact, 
		@HVACLicense, 
		@Disabled, 
		@ShowOnLocator, 
		@TopTen, 
		@Funding, 
		@Status, 
		@ActivationDate, 
		@TerminationDate, 
		@TerminationReason, 
		@LocatorPlacement, 
		@DealerThemesID, 
		@DesignStar, 
		@DesignStarActive, 
		@DesignStarGizmo, 
		@ProtectionPlus, 
		@ProtectionPlusNumber, 
		@ShowNateLogo, 
		@Cashback, 
		@CashBackSpecial, 
		@CashBackText, 
		@DesignStarManagerPersonID, 
		@ProtectionPlusEquiguard

	)

	SET @Err = @@Error


	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: InsertContractorAC Succeeded'
Else PRINT 'Procedure Creation: InsertContractorAC Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetContractorACByID') AND sysstat & 0xf = 4)
     DROP PROCEDURE GetContractorACByID;
GO

/* ------------------------------------------------------------
   PROCEDURE:    GetContractorACByID
   
   Description:  Selects record(s) from table 'ContractorAC'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE GetContractorACByID
(
	@ContractorACID uniqueidentifier

)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int

	Select 	[ContractorACID], [OrganizationID], [BrandID], [DistributorOrganizationID], [DealerNumber], [Contact], [HVACLicense], [Disabled], [ShowOnLocator], [TopTen], [Funding], [Status], [ActivationDate], [TerminationDate], [TerminationReason], [LocatorPlacement], [DealerThemesID], [DesignStar], [DesignStarActive], [DesignStarGizmo], [ProtectionPlus], [ProtectionPlusNumber], [ShowNateLogo], [Cashback], [CashBackSpecial], [CashBackText], [DesignStarManagerPersonID], [ProtectionPlusEquiguard]
	FROM [ContractorAC]
	WHERE [ContractorACID] = @ContractorACID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: GetContractorACByID Succeeded'
Else PRINT 'Procedure Creation: GetContractorACByID Error on Creation'
GO





If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('SearchContractorACByString') AND sysstat & 0xf = 4)
     DROP PROCEDURE SearchContractorACByString;
GO

/* ------------------------------------------------------------
   PROCEDURE:    SearchContractorACByString
   
   Description:  Selects a record from table 'ContractorAC'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE SearchContractorACByString
(
	@searchParam varchar(500)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	Select 	[ContractorACID], [OrganizationID], [BrandID], [DistributorOrganizationID], [DealerNumber], [Contact], [HVACLicense], [Disabled], [ShowOnLocator], [TopTen], [Funding], [Status], [ActivationDate], [TerminationDate], [TerminationReason], [LocatorPlacement], [DealerThemesID], [DesignStar], [DesignStarActive], [DesignStarGizmo], [ProtectionPlus], [ProtectionPlusNumber], [ShowNateLogo], [Cashback], [CashBackSpecial], [CashBackText], [DesignStarManagerPersonID], [ProtectionPlusEquiguard]
	FROM [ContractorAC]
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
If @@Error = 0 PRINT 'Procedure Creation: SearchContractorACByString Succeeded'
Else PRINT 'Procedure Creation: SearchContractorACByString Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('UpdateContractorAC') AND sysstat & 0xf = 4)
     DROP PROCEDURE UpdateContractorAC;
GO

/* ------------------------------------------------------------
   PROCEDURE:    UpdateContractorAC
   
   Description:  Updates a record In table 'ContractorAC'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE UpdateContractorAC
(
	@ContractorACID uniqueidentifier, 
	@OrganizationID uniqueidentifier, 
	@BrandID uniqueidentifier, 
	@DistributorOrganizationID uniqueidentifier, 
	@DealerNumber varchar(50), 
	@Contact varchar(50), 
	@HVACLicense varchar(50), 
	@Disabled bit, 
	@ShowOnLocator bit, 
	@TopTen bit, 
	@Funding varchar(50), 
	@Status varchar(50), 
	@ActivationDate datetime, 
	@TerminationDate datetime, 
	@TerminationReason varchar(50), 
	@LocatorPlacement int, 
	@DealerThemesID uniqueidentifier, 
	@DesignStar bit, 
	@DesignStarActive bit, 
	@DesignStarGizmo bit, 
	@ProtectionPlus bit, 
	@ProtectionPlusNumber varchar(50), 
	@ShowNateLogo bit, 
	@Cashback bit, 
	@CashBackSpecial bit, 
	@CashBackText text, 
	@DesignStarManagerPersonID uniqueidentifier, 
	@ProtectionPlusEquiguard varchar(50)

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	UPDATE [ContractorAC]
	SET
	[ContractorACID] = @ContractorACID, 
	[OrganizationID] = @OrganizationID, 
	[BrandID] = @BrandID, 
	[DistributorOrganizationID] = @DistributorOrganizationID, 
	[DealerNumber] = @DealerNumber, 
	[Contact] = @Contact, 
	[HVACLicense] = @HVACLicense, 
	[Disabled] = @Disabled, 
	[ShowOnLocator] = @ShowOnLocator, 
	[TopTen] = @TopTen, 
	[Funding] = @Funding, 
	[Status] = @Status, 
	[ActivationDate] = @ActivationDate, 
	[TerminationDate] = @TerminationDate, 
	[TerminationReason] = @TerminationReason, 
	[LocatorPlacement] = @LocatorPlacement, 
	[DealerThemesID] = @DealerThemesID, 
	[DesignStar] = @DesignStar, 
	[DesignStarActive] = @DesignStarActive, 
	[DesignStarGizmo] = @DesignStarGizmo, 
	[ProtectionPlus] = @ProtectionPlus, 
	[ProtectionPlusNumber] = @ProtectionPlusNumber, 
	[ShowNateLogo] = @ShowNateLogo, 
	[Cashback] = @Cashback, 
	[CashBackSpecial] = @CashBackSpecial, 
	[CashBackText] = @CashBackText, 
	[DesignStarManagerPersonID] = @DesignStarManagerPersonID, 
	[ProtectionPlusEquiguard] = @ProtectionPlusEquiguard

	WHERE [ContractorACID] = @ContractorACID

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: UpdateContractorAC Succeeded'
Else PRINT 'Procedure Creation: UpdateContractorAC Error on Creation'
GO




If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('DeleteContractorAC') AND sysstat & 0xf = 4)
     DROP PROCEDURE DeleteContractorAC;
GO

/* ------------------------------------------------------------
   PROCEDURE:    DeleteContractorAC
   
   Description:  Deletes a record from table 'ContractorAC'
   
   AUTHOR:       Rheem Manufacturing, Mike Harvey - 11/1/2010 9:06:03 AM
   ------------------------------------------------------------ */

CREATE PROCEDURE DeleteContractorAC
(
	@ContractorACID uniqueidentifier

)
As
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
	DECLARE @Err Int

	DELETE FROM [ContractorAC] 
	WHERE [ContractorACID] = @ContractorACID
		

	Set @Err = @@Error

	RETURN @Err
End
GO

-- Display the status of Proc creation
If @@Error = 0 PRINT 'Procedure Creation: DeleteContractorAC Succeeded'
Else PRINT 'Procedure Creation: DeleteContractorAC Error on Creation'
GO
		
		
