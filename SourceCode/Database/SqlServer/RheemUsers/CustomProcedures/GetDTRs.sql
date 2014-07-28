USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDTRs]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDTRs]
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
CREATE PROCEDURE [dbo].[GetDTRs] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	select PersonID, FirstName, LastName from rheemusers..Person p
		where 
	PersonID in (
		select distinct po.PersonID from RheemUsers..Organization o 
			left outer join RheemUsers ..PersonOrganization po on 
			o.OrganizationID = po.OrganizationID  
		where
			o.OrganizationType ='Technical Territory'
	) and 
	(p.disabled is null or p.disabled = '0')
	order by LastName, FirstName

END
GO
