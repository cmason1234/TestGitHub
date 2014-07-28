USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductCertificationsForOneProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductCertificationsForOneProduct]
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
CREATE PROCEDURE [dbo].[GetProductCertificationsForOneProduct] 
	@ProductID uniqueIdentifier
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

	SELECT a.CertificationID,a.DisplayName,b.ProductID, cg.GroupName
	FROM rheemusers..Certification a
	LEFT OUTER JOIN rheemusers..ProductCertification b 
	ON a.CertificationID = b.CertificationID and b.ProductID=@ProductID
	INNER JOIN rheemusers..CertificationGroup cg 
	ON a.CertificationGroupID  = cg.CertificationGroupID 
	  Order by cg.GroupName, a.DisplayName

END
GO
