USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMasterDirectReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetMasterDirectReport]
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
CREATE PROCEDURE [dbo].[GetMasterDirectReport] 
    -- Add the parameters for the stored procedure here
    @DistributorName varchar(128),
    @City varchar(50),
    @BuilderName varchar(50),
    @State varchar(3),
    @PostalCode varchar(50),
    @Region uniqueidentifier,
    @IncludeNonDirect bit,
    @StartYear int

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    CREATE TABLE #sp_Builders (
        [OrganizationID] [uniqueidentifier] NOT NULL,
        [Name] [varchar](50) NOT NULL,
        [BuilderID] [uniqueidentifier] NULL,
        [ProposalReceived] [datetime] NULL,
        [ProposalSent] [datetime] NULL,
        [BGSPersonID] [uniqueidentifier] NULL,
        [BuilderAddress] [varchar](200) NULL,
        [BuilderCity] [varchar](50) NULL,
        [BuilderState] [varchar](3) NULL,
        [BuilderZipCode] [varchar](50) NULL,
        [NAMName] [varchar](200) NULL,
        [OrgType] [varchar](50) NOT NULL,
        PRIMARY KEY (OrganizationID, OrgType)
    )

    INSERT INTO #sp_Builders 
    SELECT DISTINCT bo.OrganizationID, 
           b.BuilderName AS Name, 
           b.BuilderID,
           b.ProposalReceived,
           b.ProposalSent,
           b.BGSPersonID,
           a.AddressLine1 BuilderAddress, 
           a.City BuilderCity, 
           a.State BuilderState, 
           a.PostalCode BuilderZipCode,
           c.FirstName + ' ' + c.LastName AS NAMName,
           'Builder' AS OrgType
    FROM Builder..Builder b 
        INNER JOIN RheemUsers..BuilderOrganization bo ON b.BuilderID = bo.BuilderID 
        INNER JOIN Builder..BuilderJobSites bjs ON b.BuilderID = bjs.BuilderID 
        INNER JOIN RheemUsers..Address a ON bo.PrimaryAddressID = a.AddressID 
        LEFT OUTER JOIN RheemUsers..Person c ON b.BGSPersonID = c.PersonID 
    WHERE bjs.CompletedDate > '01-Jan-' + CAST(@StartYear AS VARCHAR) and
          bjs.CompletedDate < '31-Dec-' + CAST(@StartYear + 1 AS VARCHAR) + ' 23:59:59' and
          (LEN(@BuilderName) = 0 or b.BuilderName like '%' + @BuilderName + '%') and 
          (LEN(@City) = 0 or a.City like '%' + @City + '%') and 
          (LEN(@State) = 0 or a.State = @State) and 
          (LEN(@PostalCode) = 0 or a.PostalCode = @PostalCode) and 
          (@Region = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) or 
              bo.OrganizationID in (
                    SELECT opRE.OrganizationID 
                    FROM RheemUsers..OrganizationParent opRE                          
                    WHERE opRE.ParentOrganizationID = @Region)) 

	if LEN(@DistributorName) > 0
	BEGIN
		DELETE FROM #sp_Builders 
			where OrganizationID NOT in (
				SELECT opDis.OrganizationID 
                    FROM RheemUsers..OrganizationParent opDis 
                        INNER JOIN RheemUsers..Organization oDis on opDis.ParentOrganizationID = oDis.OrganizationID 
						INNER JOIN RheemUsers..BuilderOrganization bo2 on opDis.OrganizationID=bo2.OrganizationID
                    WHERE oDis.OrganizationName like '%' + @DistributorName + '%')
	END


    IF @IncludeNonDirect = 1 
    BEGIN
        INSERT INTO #sp_Builders 
        SELECT DISTINCT bp.BuilderProgramID AS OrganizationID,
                        bp.ProgramName AS Name,
                        NULL AS BuilderID,
                        NULL AS ProposalReceived,
                        NULL AS ProposalSent,
                        NULL AS BGSPersonID,
                        NULL AS BuilderAddress,
                        NULL AS BuilderCity,
                        NULL AS BuilderState,
                        NULL AS BuilderZipCode,
                        NULL AS NAMName,
                        'Program' AS OrgType
        FROM RheemUsers..BuilderProgram bp 
             INNER JOIN RheemUsers..BuilderProgramSales bps ON bp.BuilderProgramID = bps.BuilderProgramID 
        WHERE bps.ProgramYear = @StartYear or
              bps.ProgramYear = @StartYear + 1
        ORDER BY bp.ProgramName
    END

    SELECT * from #sp_Builders
    ORDER BY Name

    SELECT SUM(MotorBearings) AS MotorBearings,
           SUM(TotalRebate) AS TotalRebate,
           MONTH(CompletedDate) As theMonth,
           YEAR(CompletedDate) As theYear,
           bo.OrganizationID
    FROM Builder..Builder b 
        INNER JOIN RheemUsers..BuilderOrganization bo ON b.BuilderID = bo.BuilderID 
        INNER JOIN Builder..BuilderJobSites bjs ON b.BuilderID = bjs.BuilderID 
        INNER JOIN #sp_Builders c ON bo.OrganizationID = c.OrganizationID
    WHERE bjs.CompletedDate > '01-Jan-' + CAST(@StartYear AS VARCHAR) and
          bjs.CompletedDate < '31-Dec-' + CAST(@StartYear + 1 AS VARCHAR) + ' 23:59:59' and
          c.OrgType = 'Builder'
    GROUP BY bo.OrganizationID,YEAR(CompletedDate),MONTH(CompletedDate)

    SELECT bp.ProgramName,
           bps.Month,
           bps.ProgramYear,
           c.OrganizationID,
           SUM(MotorBearingUnits) AS MotorBearingUnits,
           SUM(Incentive) AS TotalRebate 
    FROM RheemUsers..BuilderProgram bp 
        INNER JOIN RheemUsers..BuilderProgramSales bps ON bp.BuilderProgramID = bps.BuilderProgramID
        INNER JOIN #sp_Builders c ON bp.ProgramName = c.Name
    WHERE (bps.ProgramYear = @StartYear or 
           bps.ProgramYear = @StartYear + 1) and
           c.OrgType = 'Program'
    GROUP BY bp.ProgramName,bps.Month,bps.ProgramYear,c.OrganizationID
    ORDER BY bp.ProgramName, bps.ProgramYear

    DROP TABLE #sp_Builders

END
GO
