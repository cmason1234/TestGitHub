USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorsForContractEnrollment]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorsForContractEnrollment]
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
CREATE PROCEDURE [dbo].[GetDistributorsForContractEnrollment] 
	-- Add the parameters for the stored procedure here
	@StartsWith varchar(128),
	@InState varchar(2),
	@RequiringNotification bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT a.State,do.*,do.DSMPersonID As origPersonID,o.*,dlp.StartDate,dlp.EndDate,dlp.NotificationDate,dlp.DistributorLocatorProcessID,
	       CASE
		   When dlp.DSMPersonID IS NULL Then pdo.FirstName + ' ' + pdo.LastName
		   Else  pdlp.FirstName + ' ' + pdlp.LastName
		   END As DSMPersonFullName,
	       CASE 
	       When dlp.StartDate IS NULL Then 9999
	       Else DATEDIFF(day, GETDATE(), DATEADD (month , 6 , dlp.StartDate )) 
	       END As DaysLeft
	FROM rheemusers..DistributorOrganization do
	    INNER JOIN rheemusers..Organization o ON do.OrganizationID=o.OrganizationID AND 
		    (do.disabled <> '1' OR do.Disabled IS NULL) and 
		    do.AC = 1 and 
		    LEN(o.OrganizationName) > 0 and
		    o.OrganizationName LIKE @StartsWith + '%'
	    INNER JOIN rheemusers..Address a ON a.AddressID = o.PrimaryAddressID and (LEN(@InState) = 0 OR a.State = @InState)
		LEFT OUTER JOIN rheemusers..DistributorLocatorProcess dlp ON dlp.OrganizationID=o.OrganizationID
		LEFT OUTER JOIN rheemusers..Person pdo ON pdo.PersonID=do.DSMPersonID
		LEFT OUTER JOIN rheemusers..Person pdlp ON pdlp.PersonID=dlp.DSMPersonID
		WHERE @RequiringNotification=0 OR (dlp.StartDate IS NOT NULL and dlp.NotificationDate IS NULL)
		order by o.OrganizationName

END
GO
