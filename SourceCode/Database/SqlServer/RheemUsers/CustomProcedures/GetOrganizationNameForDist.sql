USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOrganizationNameForDist]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetOrganizationNameForDist]
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
CREATE PROCEDURE [dbo].[GetOrganizationNameForDist]
    -- Add the parameters for the stored procedure here
    @OrgID uniqueidentifier
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT o2.OrganizationName
	FROM rheemusers..DistributorOrganization do, 
	     rheemusers..PersonOrganization po,
		 rheemusers..Organization o, 
		 rheemusers..OrganizationParent op, 
		 rheemusers..Organization o2 
	WHERE do.OrganizationId = @OrgID and
          do.DSMPersonID = po.PersonID and 
          po.OrganizationID = o.OrganizationID and 
          o.OrganizationType like '%territory%' and 
          o.OrganizationID = op.OrganizationID and 
          op.ParentOrganizationID = o2.organizationid

END
GO
