USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetGemaireAllocatedToByDistributor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetGemaireAllocatedToByDistributor]
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
CREATE PROCEDURE [dbo].[GetGemaireAllocatedToByDistributor] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT  o.OrganizationID, OrganizationName
	FROM  rheemusers..organization o, rheemusers..OrganizationParent op 
    WHERE op.ParentOrganizationID = 'eea73f84-a3ec-4c91-884e-0ab88fb5279b' and 
          o.OrganizationID   = op.OrganizationId and 
          o.OrganizationType  = 'Distributor' and 
          (o.OrganizationName like '%richmon%' or
            o.OrganizationName like '%houston%' or
            o.OrganizationName like '%pompano%' or
            o.OrganizationName like '%orlando%' or
            o.OrganizationName like '%North Car%')
            
   union
     select OrganizationID, OrganizationName from Organization 
       where OrganizationID = 'bfe18e23-1c6a-42e7-b347-b8589b509df7'
    ORDER BY OrganizationName

END
GO
