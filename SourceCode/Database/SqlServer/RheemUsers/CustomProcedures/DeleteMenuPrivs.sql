USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteMenuPrivs]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteMenuPrivs]
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
CREATE PROCEDURE [dbo].[DeleteMenuPrivs] 
	-- Add the parameters for the stored procedure here
	@MenuID uniqueidentifier
AS
BEGIN

 Delete from MenuApplicationRole where MenuID=@MenuID
 
 Delete from MenuOrganizationType where MenuID=@MenuID

 Delete from MenuBrand where MenuID=@MenuID
 
 DELETE from MenuWebSite where MenuID=@MenuID

END
GO

   
