USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTotalDebits]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTotalDebits]
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTotalDebits] 
	-- Add the parameters for the stored procedure here
	@DistributorValue uniqueidentifier,
	@ProgramValue varchar(50),
	@Year int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @DesignStarDebits float
	SET @DesignStarDebits = 	(SELECT sum(totalClaim * c.FundingSplit/100 ) * .05 FROM rheemdb..EC_Claims c 
						WHERE c.OrganizationId = @DistributorValue and 
					c.ClaimYear = @Year and 
					c.Program = @ProgramValue and 
					c.totalClaim > 0 )
		

    -- Insert statements for procedure here
    SELECT sum(totalClaim * FundingSplit/100 ) - @DesignStarDebits
	FROM rheemdb..EC_Claims c
    WHERE c.OrganizationId = @DistributorValue and 
          c.ClaimYear = @Year and 
          c.Program=@ProgramValue and (c.ClaimStatus <> 'Denied' ) and c.totalClaim < 0
END
GO
