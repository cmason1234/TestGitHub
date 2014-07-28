USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNumberOfPeopleWithTAPJobFunction]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetNumberOfPeopleWithTAPJobFunction]
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
CREATE PROCEDURE [dbo].[GetNumberOfPeopleWithTAPJobFunction]
    -- Add the parameters for the stored procedure here
    @OrgID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT COUNT(1) AS NumPeopleWithTap
    FROM  rheemusers..PersonOrganization po, 
          rheemusers..Person p, 
          rheemusers ..PersonDepartmentJob pdj, 
          rheemusers..DepartmentJobFunction djf, 
          rheemusers..JobFunction jf    
    WHERE po.OrganizationID = '68fc19d2-1d60-498a-a9eb-da5de51a412e' and 
          po.PersonID = p.PersonID and 
          p.PersonID = pdj.PersonID and 
          pdj.DepartmentJobFunctionID = djf.DepartmentJobFunctionID and 
          djf.JobFunctionID = jf.jobfunctionid and 
          jf.Description ='TAP' 


END
GO
