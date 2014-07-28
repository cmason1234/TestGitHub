USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetVDMRebateProgressByDistributor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetVDMRebateProgressByDistributor]
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
CREATE PROCEDURE [dbo].[GetVDMRebateProgressByDistributor] 
    -- Add the parameters for the stored procedure here
    @OrderByAmount bit,
	@PersonID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    IF @OrderByAmount = 0 
    BEGIN
        SELECT ROW_NUMBER () OVER (ORDER BY OrganizationName DESC) AS RowNumber,
               SUM(a.RebateAmount) AS TotalRebateAmount, 
               b.OrganizationName,
               a.OrganizationID
        FROM rheemusers..VDMRebateProgram a,
             rheemusers..Organization b,
			 rheemusers..MyOrganizations c
        WHERE a.OrganizationID=b.OrganizationID and
		      b.OrganizationID=c.OrganizationID and
			  c.PersonID=@PersonID
        GROUP BY OrganizationName, a.OrganizationID
        ORDER BY OrganizationName DESC
    END
    ELSE
    BEGIN
        SELECT ROW_NUMBER () OVER (ORDER BY SUM(a.RebateAmount)) AS RowNumber,
               SUM(a.RebateAmount) AS TotalRebateAmount, 
               b.OrganizationName,
               a.OrganizationID
        FROM rheemusers..VDMRebateProgram a,
             rheemusers..Organization b,
			 rheemusers..MyOrganizations c
        WHERE a.OrganizationID=b.OrganizationID and
		      b.OrganizationID=c.OrganizationID and
			  c.PersonID=@PersonID
        GROUP BY OrganizationName, a.OrganizationID
        ORDER BY SUM(a.RebateAmount)
    END

END
GO
