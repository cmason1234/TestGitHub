USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetWarrantyModelNumbers]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetWarrantyModelNumbers]
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
CREATE PROCEDURE [dbo].[GetWarrantyModelNumbers] 
	-- Add the parameters for the stored procedure here
	@Has13AJA bit
AS
BEGIN
    SELECT DISTINCT Model FROM Products..Product
    	WHERE DivisionID IN (select OrganizationID from Organization 
                       where OrganizationName='Rheem Heating & Cooling' and 
                              OrganizationType like 'Division%') AND
			(@Has13AJA = 1 OR Model <> '13AJA')
END
GO
