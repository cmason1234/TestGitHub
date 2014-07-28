USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductCertifications]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductCertifications]
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
CREATE PROCEDURE [dbo].[GetProductCertifications] 
	@SearchStr varchar(1000)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

	SELECT c.CertificationID, c.DisplayName, ISNULL(dt.TypeName, 'Not In Cloud DataBase') TypeName, GroupName, c.SortOrder FROM Certification c
	   INNER JOIN CertificationGroup cg on c.CertificationGroupID=cg.CertificationGroupID
       LEFT OUTER JOIN RheemUsers..CloudDocument cd ON c.CertificationID=cd.ObjectID 
                     AND cd.FriendlyName='Master Image'
       LEFT OUTER JOIN RheemUsers..DocumentType dt ON cd.DocumentTypeID=dt.DocumentTypeID
	  WHERE c.DisplayName like @SearchStr
         ORDER BY c.DisplayName

END
GO
