USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetECReportTop10]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetECReportTop10]
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
CREATE PROCEDURE [dbo].[GetECReportTop10]
    -- Add the parameters for the stored procedure here
    @year int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 10 o.OrganizationName, 
				  sum(TotalClaim * FundingSplit / 100)*-1 AS TotalClaim 
	FROM rheemdb..EC_Claims c
		INNER JOIN rheemusers..Organization o on c.OrganizationID = o.OrganizationID 
	WHERE ClaimYear=@year and 
		  TotalClaim < 0 and 
		  ClaimStatus = 'Approved' or ClaimStatus='Pending'
	GROUP BY o.OrganizationName  
	ORDER BY TotalClaim DESC

END
GO
