USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorLocatorSummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorLocatorSummary]
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
CREATE PROCEDURE [dbo].[GetDistributorLocatorSummary] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
	@StartsWith varchar(128),
	@InState varchar(2),
	@OnlyEnrolledDistributors bit 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT a.State,
	o.OrganizationType,
	       do.DSMPersonID As origPersonID,
		   o.OrganizationName,
		   o.OrganizationId,
		   dlp.StartDate,
		   dlp.EndDate,
		   dlp.NotificationDate,
		   dlp.DistributorLocatorProcessID,
		   'PUT POC HERE' As pocFullName,
	       CASE
		   When dlp.DSMPersonID IS NULL Then pdo.FirstName + ' ' + pdo.LastName
		   Else  pdlp.FirstName + ' ' + pdlp.LastName
		   END As DSMPersonFullName,
	       CASE 
	       When dlp.StartDate IS NULL Then 9999
	       Else DATEDIFF(day, GETDATE(), DATEADD (month , 6 , dlp.StartDate )) 
	       END As DaysLeft,
		   (SELECT COUNT(*) FROM rheemusers..DistributorOrganization do
		    INNER JOIN rheemusers..ContractorAC cac ON cac.DistributorOrganizationID=do.OrganizationID
		    INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=cac.OrganizationID
		    INNER JOIN rheemusers..MyOrganizations innerMO ON innerMO.OrganizationID=innerO.OrganizationID
		    WHERE do.OrganizationID=o.OrganizationID and (cac.Disabled IS NULL OR cac.Disabled=0)
		    and innerO.OrganizationType in ('Dealer', 'Contractor')
			and innerMO.PersonID=@PersonID
		    )  As ContractorCount,		   

			(SELECT COUNT(*) FROM rheemusers..DistributorOrganization do
		    INNER JOIN rheemusers..ContractorAC cac ON cac.DistributorOrganizationID=do.OrganizationID
		    INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=cac.OrganizationID
		    INNER JOIN rheemusers..MyOrganizations innerMO ON innerMO.OrganizationID=innerO.OrganizationID
		    INNER  JOIN rheemusers..ContractorLocatorAgreement cla ON cla.OrganizationID=innerO.OrganizationID and
			            cla.OrganizationID=innerO.OrganizationID AND Historical=0 and ApprovedDate IS NOT NULL
		    WHERE do.OrganizationID=o.OrganizationID and (cac.Disabled IS NULL OR cac.Disabled=0)
		    and innerO.OrganizationType in ('Dealer', 'Contractor')
			and innerMO.PersonID=@PersonID
		    )  As ContractorsUnderContract,		   

			(SELECT COUNT(*) FROM rheemusers..DistributorOrganization do
		    INNER JOIN rheemusers..ContractorAC cac ON cac.DistributorOrganizationID=do.OrganizationID
		    INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=cac.OrganizationID
		    INNER JOIN rheemusers..MyOrganizations innerMO ON innerMO.OrganizationID=innerO.OrganizationID
		    INNER  JOIN rheemusers..ContractorLocatorAgreement cla ON cla.OrganizationID=innerO.OrganizationID and
			            cla.OrganizationID=innerO.OrganizationID AND Historical=0 and DeniedDate IS NOT NULL
		    WHERE cac.DistributorOrganizationID=o.OrganizationID 
		    and innerO.OrganizationType in ('Dealer', 'Contractor')
			and innerMO.PersonID=@PersonID
		    )  As ContractorsDenied,

			(SELECT COUNT(*) FROM rheemusers..DistributorOrganization do
		    INNER JOIN rheemusers..ContractorAC cac ON cac.DistributorOrganizationID=do.OrganizationID
		    INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=cac.OrganizationID
		    INNER JOIN rheemusers..MyOrganizations innerMO ON innerMO.OrganizationID=innerO.OrganizationID
		    INNER  JOIN rheemusers..ContractorLocatorAgreement cla ON cla.OrganizationID=innerO.OrganizationID and
			            cla.OrganizationID=innerO.OrganizationID AND Historical=0 and ApprovedDate IS NULL and DeniedDate IS NULL
		    WHERE cac.DistributorOrganizationID=o.OrganizationID 
		    and innerO.OrganizationType in ('Dealer', 'Contractor')
			and innerMO.PersonID=@PersonID
		    )  As ContractorPendingApproval,
			
		   (SELECT COUNT(*) FROM rheemusers..DistributorOrganization do
		    INNER JOIN rheemusers..ContractorAC cac ON cac.DistributorOrganizationID=do.OrganizationID
		    INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=cac.OrganizationID
			INNER JOIN rheemusers..MyOrganizations innerMO ON innerMO.OrganizationID=innerO.OrganizationID
		    WHERE do.OrganizationID=o.OrganizationID and (cac.Disabled IS NULL OR cac.Disabled=0)
		    and innerO.OrganizationType in ('Dealer', 'Contractor')
			and innerMO.PersonID=@PersonID
			)
		    - 
			(SELECT COUNT(*) FROM rheemusers..DistributorOrganization do
		           INNER JOIN rheemusers..ContractorAC cac ON cac.DistributorOrganizationID=do.OrganizationID
		           INNER JOIN rheemusers..Organization innerO ON innerO.OrganizationID=cac.OrganizationID
				   INNER JOIN rheemusers..MyOrganizations innerMO ON innerMO.OrganizationID=innerO.OrganizationID
		           INNER JOIN rheemusers..ContractorLocatorAgreement cla ON cla.OrganizationID=innerO.OrganizationID and
			            cla.OrganizationID=innerO.OrganizationID AND Historical=0 and ApprovedDate IS NOT NULL
		        WHERE do.OrganizationID=o.OrganizationID and (cac.Disabled IS NULL OR cac.Disabled=0)
		        and innerO.OrganizationType in ('Dealer', 'Contractor')
				and innerMO.PersonID=@PersonID
			) As ContractorsToBeRemoved
				
	FROM rheemusers..DistributorOrganization do
	    INNER JOIN rheemusers..Organization o ON do.OrganizationID=o.OrganizationID AND 
		    (do.disabled <> '1' OR do.Disabled IS NULL) and 
		    do.AC = 1 and 
		    LEN(o.OrganizationName) > 0 and
		    o.OrganizationName LIKE @StartsWith + '%'
	    INNER JOIN rheemusers..Address a ON a.AddressID = o.PrimaryAddressID and (LEN(@InState) = 0 OR a.State = @InState)
		INNER JOIN rheemusers..MyOrganizations innerMO ON innerMO.OrganizationID=o.OrganizationID
		LEFT OUTER JOIN rheemusers..DistributorLocatorProcess dlp ON dlp.OrganizationID=o.OrganizationID
		LEFT OUTER JOIN rheemusers..Person pdo ON pdo.PersonID=do.DSMPersonID
		LEFT OUTER JOIN rheemusers..Person pdlp ON pdlp.PersonID=dlp.DSMPersonID
		WHERE 
			(@OnlyEnrolledDistributors=0 OR dlp.StartDate IS NOT NULL) 
			and innerMO.PersonID=@PersonID
		order by DaysLeft, o.OrganizationName


END
GO
