USE [warranty]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetUnitsByHomeOwnerInfoPlusSerialNum]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetUnitsByHomeOwnerInfoPlusSerialNum]
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
CREATE PROCEDURE [dbo].[GetUnitsByHomeOwnerInfoPlusSerialNum] 
	-- Add the parameters for the stored procedure here
    @SerialNum varchar(200),
	@FirstName varchar(200),
	@LastName varchar(200),
    @ContractorFirstName varchar(200),
    @ContractorLastName varchar(200)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT ho.FirstName,ho.LastName,ho.AddressLine1,ho.AddressLine2,ho.City,ho.State,
		ho.PostalCode,ho.Email,ho.Phone,
	    ho.ContractorName,ho.ContractorLastName,ho.ContractorOrgName,ho.ContractorAddressLine1,
		ho.ContractorAddressLine2,ho.ContractorCity,ho.ContractorState,ho.ContractorPostalCode,ho.ContractorEmail,ho.ContractorPhone,
        u.InstallDate,ho.RegistrationDate,b.BrandName,ho.HomeOwnerID,
		u.UnitSerial,u.UnitType,u.UnitModel,u.InstanceID,ho.OracleStatus		
	FROM Warranty..HomeOwners ho
		INNER JOIN Warranty..Units u ON u.HomeOwnerID=ho.HomeOwnerID
		INNER JOIN RheemDB..Brand b ON b.BrandID=u.UnitBrand
	WHERE FirstName like @FirstName + '%' and LastName like @LastName + '%' and u.UnitSerial IS NOT NULL and
		    ho.ContractorName like @ContractorFirstName + '%' and
		    ho.ContractorLastName like @ContractorLastName + '%' and
			u.UnitSerial like @SerialNum + '%'
			


END
GO
