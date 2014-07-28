USE [rcn]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDocumentsImproved]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDocumentsImproved]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetDocumentsImproved]
	@Abstract varchar(255),
	@Category varchar(255),
	@DocumentTitle varchar(255),
	@ModelNumber varchar(255),
	@Filename varchar(255),
	@Distribution varchar(255)

AS
BEGIN

		select Document.DocumentID, 
		DocumentTitle, 
		Filename, 
		MimeType, 
		UploadDate, 
		DocumentNumber, 
		LEFT(CAST([Abstract] as varchar(250)), 250) as Abstract, 
		Category, 
		PublicationDate, 
		Market, 
		Distribution  
		from Document 
		LEFT JOIN productdocument on productdocument.DocumentID = Document.DocumentID 
		LEFT JOIN Product on productdocument.ProductID = Product.ProductID 
		where Category in ('CS', 'CP', 'EC', 'FN', 'IN',
			'MS', 'P', 'PD', 'SP', 'TS', 'WA', 'Products', 
			'CWH', 'RWH', 'TWH', 'SWH') AND
		  (Market IN ('Residential', 'Commercial', 'Historical') OR  Market is NULL) AND
		  (@Category is NULL OR CATEGORY = @Category) AND
		  (@Distribution IS NULL or Distribution = @Distribution or Distribution='All') and 
		  (
     		  (@DocumentTitle IS NULL OR DocumentTitle like '%' + @DocumentTitle + '%') or		  
	    	  (@Filename IS NULL OR Filename LIKE '%' + @Filename + '%') or
		      (@Abstract IS NULL OR Abstract LIKE '%' + @Abstract + '%') or
			  (@ModelNumber IS NULL OR DocumentNumber LIKE '%' + @ModelNumber + '%') 
		  )
		order by PublicationDate DESC
END
GO


