USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBuildersForMasterBRIReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetBuildersForMasterBRIReport]
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
CREATE PROCEDURE [dbo].[GetBuildersForMasterBRIReport]
    -- Add the parameters for the stored procedure here
    @Year int,
    @Region uniqueidentifier,
    @State varchar(2),
    @BuilderName varchar(200)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT DISTINCT b.OrganizationName,
                    b.OrganizationID,
                    a.ProgramType,
                    c.AddressLine1+c.AddressLine2 As Address,
                    c.City,c.State,
                    c.PostalCode,
                    b.Phone
    FROM rheemusers..BuilderExternalUnitCount a
        INNER JOIN rheemusers..Organization b ON a.OrganizationID=b.OrganizationID
        INNER JOIN rheemusers..BuilderOrganization bo ON b.OrganizationID=bo.OrganizationID
        LEFT OUTER JOIN rheemusers..Address c ON b.PrimaryAddressID=c.AddressID
    WHERE a.ProgramType = 'BRI' and 
          Year=@Year and 
          (LEN(@BuilderName)=0 OR b.OrganizationName like '%' + @BuilderName + '%') and
          (LEN(@State)=0 OR c.State=@State) and
          (@Region = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) or 
              bo.OrganizationID in (
                    SELECT o.OrganizationID 
                    FROM RheemUsers..Organization o 
                        INNER JOIN RheemUsers..BuilderOrganization bo on o.OrganizationID = bo.OrganizationID 
                        INNER JOIN RheemUsers..OrganizationParent op on o.OrganizationID = op.OrganizationID 
                    WHERE op.ParentOrganizationID = @Region))
    ORDER BY b.OrganizationName
END
GO
