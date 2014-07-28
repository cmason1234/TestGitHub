USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetKwikComfortNotInContractorList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetKwikComfortNotInContractorList]
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
CREATE PROCEDURE [dbo].[GetKwikComfortNotInContractorList] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- This is just a fancy not in, which gives us a better idea of hitting a speculation number.
	
	select MerchantName, MerchantNumber, ClientSpecific, 
	  Address + '<br/>' + City + ', ' + State  as AddressValue,
	  Phone
	 from KwikComfortAnalyzer kw where 
     (0=(select COUNT(*) from ContractorOrganization where kw.MerchantNumber=KwikComfortNumber))
   Order by MerchantName
END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContractorNotInKwikComfortList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContractorNotInKwikComfortList]
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
CREATE PROCEDURE [dbo].[GetContractorNotInKwikComfortList] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	SET NOCOUNT ON;
	
	select co.OrganizationID, LTRIM(RTRIM(OrganizationName)) as OrganizationName, KwikComfortNumber, 
		AddressLine1 + '<br/>' + City + ', ' + State + ' ' + PostalCode as AddressValue,
		Phone, cac.DealerNumber
	  FROM ContractorOrganization co 
		INNER JOIN Organization o on co.OrganizationID=o.OrganizationID
		LEFT OUTER JOIN Address a on co.PrimaryAddressID=a.AddressID
		LEFT OUTER JOIN ContractorAC cac on co.OrganizationID=cac.OrganizationID
	  WHERE
    	  co.KwikComfortNumber is not null 
	       and KwikComfortNumber <> '' and
		(0=(select COUNT(*) from KwikComfortAnalyzer WHERE co.KwikComfortNumber=MerchantNumber))
	Order by OrganizationName
END
GO

