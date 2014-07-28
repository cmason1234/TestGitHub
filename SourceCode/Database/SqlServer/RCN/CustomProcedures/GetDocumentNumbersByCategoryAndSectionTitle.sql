USE [rcn]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDocumentNumbersByCategoryAndSectionTitle]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDocumentNumbersByCategoryAndSectionTitle]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetDocumentNumbersByCategoryAndSectionTitle]
    @category varchar(50),
    @sectionTitle varchar(256),
    @distribution varchar(10)

AS
BEGIN

	SELECT DISTINCT DocumentNumber
		FROM rcn..Section s 
		LEFT JOIN rcn..Document d ON s.DocumentID = d.DocumentID 
		WHERE Category = @category AND s.SectionTitle=@sectionTitle AND Distribution = @distribution

END
GO


