USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetASPContractors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetASPContractors]
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
CREATE PROCEDURE [dbo].[GetASPContractors] 
    -- Add the parameters for the stored procedure here
    @Name varchar(128),
	@City varchar(50),
	@State varchar(3),
	@Zip varchar(50),
	@Country varchar(50),
	@Disabled varchar(50)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	SELECT * FROM ContractorWaterHeater CWH
	  LEFT OUTER JOIN Organization O on CWH.OrganizationID=O.OrganizationID
	  LEFT OUTER JOIN ContractorOrganization CO on CWH.OrganizationID=CO.OrganizationID
	  LEFT OUTER JOIN ContractorRates CR on O.OrganizationID=CR.OrganizationID and RateType='CURRENT'
	  LEFT OUTER JOIN Address A on CO.PrimaryAddressID=A.AddressID
	WHERE CWH.ServiceContractor = 1 and
	(LEN(@Name) = 0 OR O.OrganizationName like '%' + @Name + '%') AND
	(LEN(@City) = 0 OR A.City LIKE '%' + @City + '%') AND
	(LEN(@State) = 0 OR A.State LIKE '%' + @State + '%') AND
	(LEN(@Zip) = 0 OR A.PostalCode = @Zip) AND
	(LEN(@Country) = 0 OR A.Country = @Country) AND
	(LEN(@Disabled) = 0 OR (
	  (CWH.Disabled = '0' OR CWH.Disabled is NULL) AND (CO.disabled is null OR CO.Disabled='0')))
	ORDER BY O.OrganizationName

END
GO
