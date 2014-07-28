USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListOfHDInstallers]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetListOfHDInstallers]
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
CREATE PROCEDURE [dbo].[GetListOfHDInstallers] 
	-- Add the parameters for the stored procedure here
	@IsAdmin bit,
	@PersonID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @IsAdmin = 0 
		SELECT distinct InstallProfessional
		FROM rheemusers..HDQuote
	    WHERE PersonID=@PersonID OR
	          PersonID in (SELECT HasAccessToPersonID 
	                       FROM rheemusers..HDPersonToPersonAccess where PersonID=@PersonID)	                       
		ORDER BY InstallProfessional
	ELSE
		SELECT distinct InstallProfessional 
		FROM rheemusers..HDQuote 
		ORDER BY InstallProfessional

END
GO
