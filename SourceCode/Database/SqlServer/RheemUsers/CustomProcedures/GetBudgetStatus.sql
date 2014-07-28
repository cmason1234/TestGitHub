USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBudgetStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetBudgetStatus]
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
CREATE PROCEDURE [dbo].[GetBudgetStatus] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
    @Year int
AS
BEGIN
SELECT f.GDPFunding, f.TCFunding, f.GDPBudgetStatus, f.TCBudgetStatus, 
     f.IgnoreSalesThresholdForTC, f.Y2TotalDollars, o.OrganizationName 
FROM  RheemUsers..Organization o
  INNER JOIN RheemUsers..MyOrganizations mo on o.OrganizationID=mo.OrganizationID and 
       mo.PersonID = @PersonID
  INNER JOIN RheemUsers..DistributorOrganization do ON o.OrganizationID    = do.OrganizationId and  
                                 do.COOPEligible        = 1
  LEFT OUTER JOIN RheemDB..EC_Forecast f on o.OrganizationID=f.OrganizationID and f.GDPYear=@Year
  order by o.OrganizationName

END
GO
