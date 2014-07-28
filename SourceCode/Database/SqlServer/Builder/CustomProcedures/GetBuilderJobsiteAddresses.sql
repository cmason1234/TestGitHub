USE [Builder]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBuilderJobsiteAddresses]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetBuilderJobsiteAddresses]
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
CREATE PROCEDURE [dbo].[GetBuilderJobsiteAddresses]
    -- Add the parameters for the stored procedure here
    @builderName varchar(200),
    @subdivName varchar(200),
    @city varchar(200),
    @state varchar(2),
    @zipCode varchar(10),
    @lotNumber varchar(200)

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT bo.OrganizationID,
           b.BuilderName,
           bjs.SubdivisionName,
           bjs.City,
           bjs.State,
           bjs.ZipCode,
           bl.LotNumber
    FROM rheemusers..BuilderOrganization bo
        INNER JOIN builder..Builder b ON b.BuilderID=bo.BuilderID
        INNER JOIN builder..BuilderJobSites bjs ON bjs.BuilderID=b.BuilderID
        INNER JOIN builder..BuilderLots bl ON bl.JobSiteID=bjs.JobSiteID
        WHERE (LEN(@builderName)=0 OR b.BuilderName like '%' + @builderName + '%') and
              (LEN(@subdivName)=0 OR bjs.SubdivisionName like '%' + @subdivName + '%') and
              (LEN(@city)=0 OR bjs.City like '%' + @city + '%') and
              (LEN(@state)=0 OR bjs.State like '%' + @state + '%') and
              (LEN(@zipCode)=0 OR bjs.ZipCode like '%' + @zipCode + '%') and
              (LEN(@lotNumber)=0 OR bl.LotNumber like '%' + @lotNumber + '%') 
    ORDER BY b.BuilderName, bl.LotNumber, bjs.SubdivisionName

END
GO
