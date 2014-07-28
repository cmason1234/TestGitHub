USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBuilderOrganizationsByYear]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetBuilderOrganizationsByYear]
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
CREATE PROCEDURE [dbo].[GetBuilderOrganizationsByYear]
    -- Add the parameters for the stored procedure here
    @Year int
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
		LEFT OUTER JOIN rheemusers..Address c ON b.PrimaryAddressID=c.AddressID
    WHERE a.ProgramType in ('BRI','AirTime','Service Experts') and 
          Year=@Year
    ORDER BY b.OrganizationName

END
GO
