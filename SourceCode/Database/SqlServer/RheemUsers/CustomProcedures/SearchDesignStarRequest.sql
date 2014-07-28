USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchDesignStarRequest]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchDesignStarRequest]
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
CREATE PROCEDURE [dbo].[SearchDesignStarRequest] 
	-- Add the parameters for the stored procedure here
	-- no params for this stored procedure
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select a.*,b.FirstName + ' ' + b.LastName as RequestedByName, o.OrganizationName 
	FROM rheemusers..DesignStarRequest a, rheemusers..Person b, rheemusers..Organization o 
    WHERE a.RequestedByPersonID = b.PersonID and 
          a.ParentOrganizationID = o.OrganizationID 
    ORDER BY a.LastName,a.FirstName

END
GO
