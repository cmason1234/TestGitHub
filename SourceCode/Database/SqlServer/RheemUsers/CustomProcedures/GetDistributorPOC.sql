USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorPOC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorPOC]
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
CREATE PROCEDURE [dbo].[GetDistributorPOC] 
	-- Add the parameters for the stored procedure here
	@OrgID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT DISTINCT p.FirstName + ' ' + p.LastName As PersonFullName, p.PersonId
	FROM rheemusers..person p, 
		 rheemusers..PersonOrganization po,  
		 rheemusers..PersonDepartmentJob pdjf, 
		 rheemusers..DepartmentJobFunction djf, 
		 rheemusers..JobFunction jf
	WHERE po.OrganizationID in (SELECT OrganizationID from rheemusers ..Organization 
								WHERE OrganizationID = @OrgID OR
									  OrganizationID in (SELECT ParentOrganizationID 
														 FROM rheemusers..OrganizationParent 
														 WHERE OrganizationID = @OrgID )) and 
		  po.PersonID = pdjf.PersonID and 
		  pdjf.DepartmentJobFunctionID = djf.DepartmentJobFunctionID and 
		  djf.JobFunctionID = jf.JobFunctionID and 
		  jf.Description in ('RT Coordinator', 'RR Coordinator') and 
		  po.PersonID = p.PersonID 

END
GO
