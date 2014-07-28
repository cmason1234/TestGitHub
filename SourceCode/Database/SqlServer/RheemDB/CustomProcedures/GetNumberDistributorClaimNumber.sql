USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNumberDistributorClaimNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetNumberDistributorClaimNumber]
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
CREATE PROCEDURE [dbo].[GetNumberDistributorClaimNumber] 
	-- Add the parameters for the stored procedure here
	@DistributorValue uniqueidentifier,
	@Year int,
	@DistributorClaimNumber varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT count(DistributorClaimNumber) FROM RheemDB..EC_Claims 
    WHERE DistributorClaimNumber = @DistributorClaimNumber and 
         OrganizationId = @DistributorValue and 
         ClaimYear = @Year
END
GO
