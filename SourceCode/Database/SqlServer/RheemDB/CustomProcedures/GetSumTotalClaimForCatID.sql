USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSumTotalClaimForCatID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetSumTotalClaimForCatID]
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
CREATE PROCEDURE [dbo].[GetSumTotalClaimForCatID] 
	-- Add the parameters for the stored procedure here
	@OrgID uniqueidentifier,
	@Program varchar(50),
	@CreditClaimSectionCatID uniqueidentifier,
	@Year int
AS
BEGIN
DECLARE @sql nvarchar(MAX),
        @paramlist  nvarchar(4000)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT @sql = 'SELECT SUM(TotalClaim) 
                   FROM rheemdb..EC_Claims
                   WHERE OrganizationId = @OrgID and
                         Program = @Program and
                         ClaimYear = @Year '

    IF @CreditClaimSectionCatID IS NOT NULL
	BEGIN
        SELECT @sql = @sql + ' and ClaimSectionCategoryID = @CreditClaimSectionCatID '
    END
	IF @Program = 'PROSTOCK'
	BEGIN
        SELECT @sql = @sql + ' and TotalClaim  > 0 '
	END

	 SELECT @paramlist = '@orgID                    uniqueidentifier,                             
                          @program                  varchar(50),                       
                          @creditClaimSectionCatID  uniqueidentifier,    
			              @year                     int '      

     EXEC sp_executesql @sql, @paramlist, @OrgID, @Program, @CreditClaimSectionCatID, @Year

END
GO
