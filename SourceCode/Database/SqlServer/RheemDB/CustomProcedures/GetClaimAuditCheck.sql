USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClaimAuditCheck]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClaimAuditCheck]
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
CREATE PROCEDURE [dbo].[GetClaimAuditCheck] 
	-- Add the parameters for the stored procedure here
	@OrganizationID uniqueidentifier,
    @Year int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT (COUNT(*) + 1) % AuditFrequency  AS ModAuditFrequency from EC_Claims ECC
	  INNER JOIN EC_Forecast ECF on ECF.OrganizationID=ECC.OrganizationID and
		 ECF.GDPYear=ECC.ClaimYear
	  WHERE ecc.OrganizationID = @OrganizationID AND
    	ClaimYear = @Year AND
	    TotalClaim < 0
	  GROUP BY AuditFrequency
END
GO
