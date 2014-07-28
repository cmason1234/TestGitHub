USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBuilderUnitTotalsForMasterBRIReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetBuilderUnitTotalsForMasterBRIReport]
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
CREATE PROCEDURE [dbo].[GetBuilderUnitTotalsForMasterBRIReport]
    -- Add the parameters for the stored procedure here
    @Year int,
    @State varchar(2),
    @Region uniqueidentifier,
    @BuilderName varchar(200)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT SUM(Incentive) as Incentive, 
           SUM(MotorBearingUnits) as MotorBearingUnits, 
           Month 
    FROM rheemusers..BuilderExternalUnitCount beuc
        INNER JOIN rheemusers..Organization o ON o.OrganizationId=beuc.OrganizationId
        INNER JOIN rheemusers..BuilderOrganization bo ON bo.OrganizationID=o.OrganizationID
        LEFT OUTER JOIN rheemusers..Address a ON a.AddressID=o.PrimaryAddressID
    WHERE beuc.ProgramType='BRI' and 
          Year=@Year and
          (LEN(@BuilderName)=0 OR o.OrganizationName like '%' + @BuilderName + '%') and 
          (LEN(@State)=0 OR a.State=@State) and
          (@Region = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) or 
              bo.OrganizationID in (
                    SELECT o.OrganizationID 
                    FROM RheemUsers..Organization o 
                        INNER JOIN RheemUsers..BuilderOrganization bo on o.OrganizationID = bo.OrganizationID 
                        INNER JOIN RheemUsers..OrganizationParent op on o.OrganizationID = op.OrganizationID 
                    WHERE op.ParentOrganizationID = @Region))
          
          
    GROUP BY Month

END
GO
