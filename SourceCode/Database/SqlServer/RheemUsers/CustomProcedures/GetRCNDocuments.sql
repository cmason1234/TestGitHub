USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRCNDocuments]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRCNDocuments]
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
CREATE PROCEDURE [dbo].[GetRCNDocuments] 
	-- Add the parameters for the stored procedure here
	@DocumentTitle varchar(255),
	@Category varchar(255),
    @FileType varchar(255),
    @Distribution varchar(255),
    @Level1Sub varchar(255),
    @Level2Sub varchar(255),
    @Level3Sub varchar(255),
    @Level4Sub varchar(255),
    @Level5Sub varchar(255)
AS

   SELECT DocumentID, DocumentTitle, Filename, MimeType, 
     UploadDate, DocumentNumber, Distribution, Category 
   FROM rcn..Document WHERE 
   (len(@DocumentTitle) = 0 or DocumentTitle like @DocumentTitle) AND
   (LEN(@Category) = 0 OR Category = @Category) AND
   (LEN(@FileType) = 0 OR MimeType LIKE @FileType) AND
   (LEN(@Distribution) = 0 or Distribution in(@Distribution, 'All')) AND
   (LEN(@Level1Sub) = 0 or 
      (DocumentID in (Select DocumentID from rcn..Section where SectionTitle=@Level1Sub))) AND
   (LEN(@Level2Sub) = 0 or 
      (DocumentID in (Select DocumentID from rcn..Section where SectionTitle=@Level2Sub))) AND
   (LEN(@Level3Sub) = 0 or 
      (DocumentID in (Select DocumentID from rcn..Section where SectionTitle=@Level3Sub))) AND
   (LEN(@Level4Sub) = 0 or 
      (DocumentID in (Select DocumentID from rcn..Section where SectionTitle=@Level4Sub))) AND
   (LEN(@Level5Sub) = 0 or 
      (DocumentID in (Select DocumentID from rcn..Section where SectionTitle=@Level5Sub)))
    order by DocumentTitle DESC 

GO


   
