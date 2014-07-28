USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOrganizationsPeopleJobFunctions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetOrganizationsPeopleJobFunctions]
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
CREATE PROCEDURE [dbo].[GetOrganizationsPeopleJobFunctions]
    -- Add the parameters for the stored procedure here
    @OrgID uniqueidentifier
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT po.PersonID, d.DepartmentName, jf.Description
        FROM rheemusers..PersonOrganization po 
        inner join PersonDepartmentJob pdj on po.PersonID = pdj.PersonID
        inner join DepartmentJobFunction djf on pdj.DepartmentJobFunctionID = djf.DepartmentJobFunctionID
        inner join Department d on djf.DepartmentID=d.DepartmentID
        inner join JobFunction jf on djf.JobFunctionID=jf.JobFunctionID 
        WHERE po.OrganizationID  = @OrgID 
END
GO
