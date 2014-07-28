USE [warranty]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUnitsByHomeOwnerInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetUnitsByHomeOwnerInfo]
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
CREATE PROCEDURE [dbo].[GetUnitsByHomeOwnerInfo] 
	-- Add the parameters for the stored procedure here
	@FirstName varchar(200),
	@LastName varchar(200),
	@City varchar(200),
    @State varchar(200),
    @ZipCode varchar(200),
    @ContractorName varchar(200),
	@StartDate datetime,
	@EndDate datetime

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT u.UnitSerial,u.UnitModel,u.UnitType,b.BrandName,ho.FirstName,
		ho.LastName,ho.AddressLine1,ho.AddressLine2,ho.City,ho.State,
		ho.PostalCode, ho.ContractorName 
	FROM Warranty..HomeOwners ho
		INNER JOIN Warranty..Units u ON u.HomeOwnerID=ho.HomeOwnerID
		INNER JOIN RheemDB..Brand b ON b.BrandID=u.UnitBrand
	WHERE FirstName like @FirstName + '%' and LastName like @LastName + '%' and u.UnitSerial IS NOT NULL and
			ho.City like @City + '%' and ho.State like @State + '%' and ho.PostalCode like @ZipCode + '%' and
            ho.ContractorName like @ContractorName + '%' and
			(@StartDate is null or ho.RegistrationDate between @StartDate and @EndDate) 


END
GO
