/*
Use [RheemDB]
GO

CREATE PROCEDURE [dbo].[Insert2013EClaimCategory]
(
    @ClaimSectionID uniqueidentifier,
    @CategoryName varchar(100),    
    @FundingSplit int,
    @ApprovalRequired bit,
    @NonBilling bit,
    @FixedCost bit,
    @FixedCostPercent float,    
    @OracleRheemAccountCode varchar(50)     
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
  INSERT INTO [RheemDB].[dbo].[EC_ClaimSectionCategory]
           ([ClaimSectionCategoryID] ,[ClaimSectionID] ,[CategoryName]  ,[RheemAccountCode] ,[RuudAccountCode] ,[FundingSplit]
           ,[FundingSplitSingleLine] ,[ApprovalRequired] ,[OtherRequired],[NonBilling] ,[FixedCost]  ,[FixedCostPercent]
           ,[OracleRheemAccountCode] ,[OracleRuudAccountCode])
     VALUES
           (NEWID(), @ClaimSectionID, @CategoryName, NULL, NULL, @FundingSplit, @FundingSplit, 
           @ApprovalRequired,  NULL, @NonBilling, @FixedCost, @FixedCostPercent, @OracleRheemAccountCode, @OracleRheemAccountCode 
			)
End
go


CREATE PROCEDURE [dbo].[Insert2013EClaimSection]
(
    @ClaimSectionID uniqueidentifier,
	@GDPYear int,
    @SectionName varchar(100),
    @MinRequirement bit,
    @MaxRequirement bit,
    @GDPSection bit,
    @TCSection bit,
    @ProStockSection bit,
    @SpecialProgramSection bit,
    @MinPercent int,
    @MaxPercent int        
)

AS
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN
    INSERT INTO [RheemDB].[dbo].[EC_ClaimSection] ([ClaimSectionID], [GDPYear] ,[SectionName],[MinRequirement] ,[MaxRequirement]
           ,[GDPSection] ,[TCSection] ,[ProStockSection] ,[SpecialProgramSection]
           ,[MinPercent]
           ,[MaxPercent])
     VALUES
           (@ClaimSectionID, @GDPYear, @SectionName, @MinRequirement, @MaxRequirement, @GDPSection,
    @TCSection,  @ProStockSection , @SpecialProgramSection , @MinPercent , @MaxPercent )
End
go







declare @cnt integer


delete  from rheemdb..EC_Forecast where GDPYear =2013
delete  from rheemdb..EC_BudgetLog where GDPYear = 2013
delete  from rheemdb..EC_BudgetMiscInfo  where BudgetYear = 2013
delete  from rheemdb..EC_ClaimBudget   where BudgetYear = 2013
delete from rheemdb..EC_Claims where ClaimYear = 2013
Delete from EC_ClaimSectionCategory where ClaimSectionID in (select ClaimSectionID from EC_ClaimSection where GDPYear=2013)
delete from EC_ClaimSection where GDPYear=2013


Select @cnt=COUNT(1) FROM EC_ClaimSection WHERE GDPYear=2013

IF @cnt = 0
    BEGIN

		
	
   		Declare @sectionID uniqueidentifier

		declare @MinRequirement bit
		declare @MaxRequirement bit
		declare @GDPSection bit
		declare @TCSection bit
		declare @PROSTOCKSection bit
		declare @SPSection bit
		Declare @OracleAccountCodeGDP varchar(50)
		Declare @OracleAccountCodeTC varchar(50)
		
		declare @FundingSplit int
		declare	@FundingSplitSingleLine int
		declare @ApprovalRequired bit
		declare @NonBilling bit
		declare @FixedCost bit
		declare @FixedCostPercent float
		
		SELECT 'Creating Credits'
		SET @sectionID = NEWID()
		set @MinRequirement = 0
		set @MaxRequirement = 0
		set @GDPSection = 1
		set @TCSection = 1
		set @PROSTOCKSection = 1
		set @SPSection = 1
		
		set @FundingSplit =100
		set @ApprovalRequired = 0
		set @NonBilling = 0
		set @FixedCost = 0
		set @FixedCostPercent = 0
		set @OracleAccountCodeGDP='GDP Claims'
		
		exec Insert2013EClaimSection @sectionID, 2013, 'Credits', False, False, @GDPSection, @TCSection, @PROSTOCKSection, @SPSection, 0, 0
		
		exec Insert2013EClaimCategory @sectionID, 'Credit', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
		
       

		
		SELECT 'Creating Design star'
		SET @sectionID = NEWID()
		set @MinRequirement = 0
		set @MaxRequirement = 0
		set @GDPSection = 1
		set @TCSection = 0
		set @PROSTOCKSection = 0
		set @SPSection = 0
		
		set @FundingSplit =100
		set @ApprovalRequired = 0
		set @NonBilling = 0
		set @FixedCost = 1
		set @FixedCostPercent = 7.5

		exec Insert2013EClaimSection @sectionID, 2013, 'Design Star', False, False, @GDPSection, @TCSection, @PROSTOCKSection, @SPSection, 0, 0
		
		exec Insert2013EClaimCategory @sectionID, 'Design Star', @FundingSplit, 
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP

		
      	SELECT 'Consumer Marketing / Advertising'
 	    SET @sectionID = NEWID()
		set @MaxRequirement = 45
		set @FundingSplit =50
		set @FixedCost = 0
		set @FixedCostPercent = 0
       
		exec Insert2013EClaimSection @sectionID, 2013, 'Consumer Marketing / Advertising', False, True, 
		@GDPSection, @TCSection, @PROSTOCKSection, @SPSection, 0, 45
		
		exec Insert2013EClaimCategory @sectionID, 'All Media', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
		exec Insert2013EClaimCategory @sectionID, 'Identification', @FundingSplit, 
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
				
				
				
		SELECT 'Contractor Recruiting & Retention'
 	    SET @sectionID = NEWID()	
		
		exec Insert2013EClaimSection @sectionID, 2013, 'Contractor Recruiting & Retention', False, True, 
		@GDPSection, @TCSection, @PROSTOCKSection, @SPSection, 0, 35
		
		exec Insert2013EClaimCategory @sectionID, 'Incentive Trips', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
		exec Insert2013EClaimCategory @sectionID, 'Plant Tours', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
		exec Insert2013EClaimCategory @sectionID, 'Contractor Recognition & Awards', @FundingSplit, 
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
		exec Insert2013EClaimCategory @sectionID, 'New Contractor Acquisiton & Contractor Retention', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP

		set @FundingSplit =100
		exec Insert2013EClaimCategory @sectionID, 'Motorsports Program', @FundingSplit, 
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP

		
		
		SELECT 'Publications - Product Training & Sales Literature'
 	    SET @sectionID = NEWID()	
		set @FundingSplit =75
		exec Insert2013EClaimSection @sectionID, 2013, 'Publications - Product Training & Sales Literature', False, True, 
		@GDPSection, @TCSection, @PROSTOCKSection, @SPSection, 0, 15
		
		exec Insert2013EClaimCategory @sectionID, 'Coolzone Purchased Product or Marktering Literature', @FundingSplit, 
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP

		set @FundingSplit =25
		exec Insert2013EClaimCategory @sectionID, 'Rheem Produced Literature - Printed Locally', @FundingSplit, 
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
				


		SELECT 'Training'
 	    SET @sectionID = NEWID()	
		
		exec Insert2013EClaimSection @sectionID, 2013, 'Training', True, False, 
		@GDPSection, @TCSection, @PROSTOCKSection, @SPSection, 10, 0

		set @FundingSplit =100
		exec Insert2013EClaimCategory @sectionID, 'Rheem Academy/Training For Distributors', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
		
		set @FundingSplit =75
		exec Insert2013EClaimCategory @sectionID, 'Rheem Approved Training for Distributors (Non-Rheem Academy)', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP

		set @FundingSplit =50
		exec Insert2013EClaimCategory @sectionID, 'Rheem Academy/Training & Literature For Contractors', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP

		exec Insert2013EClaimCategory @sectionID, 'Rheem Approved Training for Contractors (Non-Rheem Academy)', @FundingSplit, 
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP






		

		SELECT 'DSM Discretionary'
 	    SET @sectionID = NEWID()	
		
		exec Insert2013EClaimSection @sectionID, 2013, 'DSM Discretionary', False, True, 
		@GDPSection, @TCSection, @PROSTOCKSection, @SPSection, 0, 10

		set @FundingSplit =100
		SET @FixedCost = 0	
		SET @FixedCostPercent = 0		 
		SET @ApprovalRequired = 1		 
		exec Insert2013EClaimCategory @sectionID, 'DSM - Consumer Marketing & Advertising', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP				
		exec Insert2013EClaimCategory @sectionID, 'DSM - Contractor Recruiting & Retention', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
		exec Insert2013EClaimCategory @sectionID, 'DSM - Training', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP


		SELECT 'RSM Discretionary'
 	    SET @sectionID = NEWID()	
		
		exec Insert2013EClaimSection @sectionID, 2013, 'RSM Discretionary', False, True, 
		@GDPSection, @TCSection, @PROSTOCKSection, @SPSection, 0, 5

		exec Insert2013EClaimCategory @sectionID, 'RSM - Consumer Marketing & Advertising', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP				
		exec Insert2013EClaimCategory @sectionID, 'RSM - Contractor Recruiting & Retention', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
		exec Insert2013EClaimCategory @sectionID, 'RSM - Training', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
		exec Insert2013EClaimCategory @sectionID, 'RSM - Publications - Product Training & Sales Literature', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
				
	

	
	
	
	
      	SELECT 'TC - Consumer Marketing / Advertising'
 	    SET @sectionID = NEWID()
		set @FundingSplit =80
		set @GDPSection = 0
		set @TCSection = 1
		set @ApprovalRequired = 0
		set @FixedCost = 0
		set @FixedCostPercent = 0
		set @OracleAccountCodeGDP='Team Top_Contractor'
		
		exec Insert2013EClaimSection @sectionID, 2013, 'Consumer Marketing / Advertising', False, False, 
		@GDPSection, @TCSection, @PROSTOCKSection, @SPSection, 0, 0
		
		exec Insert2013EClaimCategory @sectionID, 'All Media', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
		exec Insert2013EClaimCategory @sectionID, 'Identification', @FundingSplit, 
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
				
				

		SET @sectionID = NEWID()
		exec Insert2013EClaimSection @sectionID, 2013, 'Contracting Recruiting & Retention', False, False, 
		@GDPSection, @TCSection, @PROSTOCKSection, @SPSection, 0, 0
		
		exec Insert2013EClaimCategory @sectionID, 'Incentive Trips', @FundingSplit,  
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
		exec Insert2013EClaimCategory @sectionID, 'Plant Tours', @FundingSplit, 
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
		exec Insert2013EClaimCategory @sectionID, 'Contractor Recognition & Awards', @FundingSplit, 
				@ApprovalRequired, @NonBilling, @FixedCost, @FixedCostPercent, @OracleAccountCodeGDP
				
				
				
				
	END
    
drop procedure [dbo].[Insert2013EClaimCategory]
drop procedure [dbo].[Insert2013EClaimSection]

 */
