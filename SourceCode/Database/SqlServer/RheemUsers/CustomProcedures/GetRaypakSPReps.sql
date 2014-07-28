USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRaypakSPReps]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRaypakSPReps]
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
CREATE PROCEDURE [dbo].[GetRaypakSPReps] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
	@Name varchar(50),
	@RepNumber varchar(50),
	@Disabled bit,
	@City varchar(50),
	@State varchar(50),
	@Zip varchar(50),
	@Country varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	select * from MyOrganizations mo
	INNER JOIN Organization o on mo.OrganizationID = o.OrganizationID
	INNER JOIN raypakpsreporganization rsp on o.OrganizationID = rsp.OrganizationID
	LEFT OUTER JOIN Address a on o.PrimaryAddressID = a.AddressID
	where 
	  mo.PersonID = @PersonID and
	  (LEN(@Name) = 0 or o.OrganizationName like '%' + @Name + '%') AND
	  (LEN(@RepNumber) = 0 or rsp.RepNumber like '%' + @RepNumber + '%') AND
	  (@Disabled is null or @Disabled = rsp.Disabled) AND
	  (LEN(@City) = 0 or a.City like '%' + @City + '%') AND
	  (LEN(@State) = 0 or a.State like '%' + @State + '%') AND
	  (LEN(@Zip) = 0 or a.PostalCode like '%' + @Zip + '%') AND
	  (LEN(@Country) = 0 or a.Country like '%' + @Country + '%')
	order by o.organizationName 

END
GO
