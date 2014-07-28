USE [RheemUsers]
GO
/****** Object:  StoredProcedure [dbo].[GetCloudPDFByObjectId]    Script Date: 06/21/2012 15:52:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[GetCloudPDFByObjectId]
    -- Add the parameters for the stored procedure here
    @ObjectID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT CloudDocumentID, ObjectID, ObjectType, DocumentTitle, DocumentNumber, ObjectDocumentNumber, 
	     FriendlyName, Abstract, Disabled, UploadedFileName, CloudFileName, CloudBucket, FileExtension,
		 cd.DocumentTypeID, TypeName
    FROM CloudDocument cd
        INNER JOIN DocumentType dt ON cd.DocumentTypeID=dt.DocumentTypeID
    WHERE cd.FileExtension='PDF' and cd.ObjectID=@ObjectID
    ORDER BY FriendlyName

END
