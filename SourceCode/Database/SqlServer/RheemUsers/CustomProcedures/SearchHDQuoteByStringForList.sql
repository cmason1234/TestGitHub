﻿USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchHDQuoteByStringForList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SearchHDQuoteByStringForList]
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
/* ------------------------------------------------------------
   PROCEDURE:    SearchHDQuoteByStringForList
   
   Description:  Selects a record from table 'HDQuote'
   				 And puts values into parameters
   
   AUTHOR:       Rheem Manufacturing, Brian White - 9/6/2011 9:58:14 AM
   
   Generated by MyGeneration Version 1.3.0.9
   ------------------------------------------------------------ */

CREATE PROCEDURE [dbo].[SearchHDQuoteByStringForList]
(
	@searchParam varchar(4000)
)
As
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @Err Int
	DECLARE @strSql varchar(4000)
	
	SET @strSql = '	SELECT dbo.HDQuote.HDQuoteID, dbo.HDQuote.PersonID, dbo.HDQuote.CustomerFirst, dbo.HDQuote.CustomerLast,
		dbo.HDQuote.LeadNumber, dbo.HDQuote.OrganizationID, dbo.Organization.OrganizationName, 
		dbo.Person.FirstName, dbo.Person.LastName, dbo.HDQuote.ProposalDate, dbo.HDQuote.StoreNumber,
		dbo.HDQuote.CustomerPhoneDay, dbo.HDQuote.CustomerPhoneNight 
		FROM dbo.HDQuote INNER JOIN
		dbo.Organization ON dbo.HDQuote.OrganizationID = dbo.Organization.OrganizationID INNER JOIN
		dbo.Person ON dbo.HDQuote.PersonID = dbo.Person.PersonID
		WHERE ' +  @searchParam

	EXEC(@strSql)

End
GO
