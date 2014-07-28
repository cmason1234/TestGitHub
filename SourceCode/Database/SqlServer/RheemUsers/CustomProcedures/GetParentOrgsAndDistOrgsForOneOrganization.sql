USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetParentOrgsAndDistOrgsForOneOrganization]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetParentOrgsAndDistOrgsForOneOrganization]
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
CREATE PROCEDURE [dbo].[GetParentOrgsAndDistOrgsForOneOrganization]
    -- Add the parameters for the stored procedure here
    @OrgID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT * 
    FROM  RheemUsers..organization o, RheemUsers..organizationparent op, RheemUsers..DistributorOrganization do 
    WHERE o.organizationid = do.organizationid and 
          o.organizationid = op.organizationid and 
          op.parentorganizationid = @OrgID
ORDER BY o.OrganizationName, DistributorNumber

END
GO
