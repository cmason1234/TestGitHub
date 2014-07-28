USE [RheemUsers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CanDeletePerson]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CanDeletePerson]

/****** Object:  UserDefinedFunction [dbo].[CountQuotes]    Script Date: 05/18/2012 09:52:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE PROCEDURE [dbo].[CanDeletePerson] 
(
	-- Add the parameters for the function here
@PersonID uniqueidentifier
)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @CNRequest as integer
	SET @CNRequest = ( select count(*) from RheemDB..CNRequest where OrganizedBy = @PersonID )

	DECLARE @CNRequestApprover as integer
	SET @CNRequestApprover =  ( select count(*) from RheemDB..CNRequestApprover where ApproveDate is not null and PersonID = @PersonID )

	DECLARE @HDLiteratureOrders as integer
	SET @HDLiteratureOrders =  ( select count(*) from RheemUsers..HDLiteratureOrders where PersonID = @PersonID )

	DECLARE @ContractorLocatorAgreement as integer
	SET @ContractorLocatorAgreement =  ( select count(*) from RheemUsers..ContractorLocatorAgreement where SubmittedByPersonID = @PersonID or ApprovedByPersonID = @PersonID or DeniedByPersonID = @PersonID )

	DECLARE @Instructor as integer
	SET @Instructor =  ( select  count(*) from TheTrainingNetwork..training_classes where InstructorID = @PersonID)

	DECLARE @Contact as integer
	SET @Contact =  ( select  count(*) from TheTrainingNetwork..training_classes where ContactID = @PersonID)

	DECLARE @Scheduler as integer
	SET @Scheduler =  ( select  count(*) from TheTrainingNetwork..training_classes where SchedulerID =@PersonID)

	DECLARE @ReturnValue as bit
	
	IF @CNRequest =0 and 
		@CNRequestApprover=0 and 
		@HDLiteratureOrders=0 and
		@ContractorLocatorAgreement=0 and
		@Instructor=0 and 
		@Contact=0 and 
		@Scheduler=0 
		
		set @ReturnValue =1
	else
		set @ReturnValue =0
		
	select @ReturnValue
END

GO


