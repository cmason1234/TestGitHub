USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetAllProgramSalesByProgramType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetAllProgramSalesByProgramType]
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
CREATE PROCEDURE [dbo].[GetAllProgramSalesByProgramType]
    -- Add the parameters for the stored procedure here
    @Year int,
    @ProgramType varchar(50),
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
           a.Month, 
           b.OrganizationName, 
           c.AddressLine1+c.AddressLine2 As Address,
           c.City,
           c.State,
           c.PostalCode,
           b.Phone,
           a.ProgramType
    FROM rheemusers..BuilderExternalUnitCount a
         INNER JOIN rheemusers..Organization b ON b.OrganizationId=a.OrganizationId
         LEFT OUTER JOIN rheemusers..Address c ON c.AddressId=b.PrimaryAddressId
    WHERE a.Year=@Year and 
          a.ProgramType=@ProgramType and
          (LEN(@BuilderName)=0 OR b.OrganizationName like '%' + @BuilderName + '%') and 
          (LEN(@State)=0 OR c.State=@State) and
          --(@Region = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) or 1=0)
          (@Region = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) or 
              b.OrganizationID in (
                    SELECT o.OrganizationID 
                    FROM RheemUsers..Organization o 
                        INNER JOIN RheemUsers..Organization innerO on innerO.OrganizationID = b.OrganizationID 
                        INNER JOIN RheemUsers..OrganizationParent op on o.OrganizationID = op.OrganizationID 
                    WHERE op.ParentOrganizationID = @Region))
    GROUP BY b.OrganizationName,
             a.Month,
             c.AddressLine1,
             c.AddressLine2,
             c.City,
             c.State,
             c.PostalCode,
             b.Phone,
             a.ProgramType 
    ORDER BY b.OrganizationName,a.Month 

END
GO
