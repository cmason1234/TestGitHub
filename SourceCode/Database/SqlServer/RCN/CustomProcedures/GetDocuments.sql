USE [rcn]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getDocuments]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[getDocuments]
GO



/****** Object:  StoredProcedure [dbo].[getDocuments]    Script Date: 04/03/2013 13:42:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Neal Colston
-- Description:	Search to Handle multiple terms or lack thereof
-- NOTE:        BIG HACK because .Net 2.0 couldn't seem to handle NULL values
-- correctly with a datasource, so I'm using crazy default values instead of NULL
-- =============================================

CREATE PROCEDURE [dbo].[getDocuments]
@Abstract varchar(255),
@Category varchar(255),
@FileType varchar(255),
@DocumentTitle varchar(255),
@Rheem varchar(255),
@Ruud varchar(255),
@ModelNumber varchar(255),
@Filename varchar(255),
@Distribution varchar(255)

AS

declare @categoryString varchar(255)
declare @DocumentTitleString varchar(255)
declare @ModelNumberString varchar(255)
declare @FilenameString varchar(255)
declare @AbstractString varchar(255)
declare @sqlString varchar(1024)
declare @sqlString2 varchar(1024)
declare @distributionString varchar(255)

set @categoryString = ''
set @DocumentTitleString = ''
set @ModelNumberString = ''
set @FilenameString = ''
set @AbstractString = ''

if @Distribution = 'All'
begin
if @Rheem = 'Rheem' AND @Ruud = 'Ruud'
begin
set @distributionString = ''
end

else if @Rheem = 'Rheem'
begin
set @distributionString = 'AND ((Distribution LIKE ' + char(39) + 'Rheem' + char(39) + '))'
end

else if @Ruud = 'Ruud'
begin
set set @distributionString = 'AND ((Distribution LIKE ' + char(39) + 'Ruud' + char(39) + '))'
end

end -- ends the beginning Distribution if

else if @Ruud = 'Ruud' AND @Distribution = 'Ruud'
begin
set set @distributionString = 'AND ((Distribution LIKE ' + char(39) + 'Ruud' + char(39) + ') OR (Distribution LIKE ' + char(39) + 'All' + char(39) + '))'
end

else if @Rheem = 'Rheem' AND @Distribution = 'Rheem'
begin
set @distributionString = 'AND ((Distribution LIKE ' + char(39) + 'Rheem' + char(39) + ') OR (Distribution LIKE ' + char(39) + 'All' + char(39) + '))'
end

else if @Ruud = 'Ruud'
begin
set set @distributionString = 'AND ((Distribution LIKE ' + char(39) + 'Ruud' + char(39) + ') OR (Distribution LIKE ' + char(39) + 'All' + char(39) + '))'
end

else if @Rheem = 'Rheem'
begin
set @distributionString = 'AND ((Distribution LIKE ' + char(39) + 'Rheem' + char(39) + ') OR (Distribution LIKE ' + char(39) + 'All' + char(39) + '))'
end

set @sqlString = 'SELECT [DocumentID], 
				[DocumentTitle], 
				[Filename], 
				[MimeType], 
				[UploadDate], 
				[DocumentNumber], 
				LEFT(CAST([Abstract] as varchar(250)), 250) as Abstract, 
				[Distribution], 
				[Category] 
	FROM (select Document.DocumentID, 
			DocumentTitle, 
			Filename, 
			MimeType, 
			UploadDate, 
			DocumentNumber, 
			Abstract, 
			Category, 
			PublicationDate, 
			Market, 
			Distribution  
			from Document LEFT JOIN productdocument 
			on productdocument.DocumentID = Document.DocumentID LEFT JOIN Product 
			on productdocument.ProductID = Product.ProductID 
			where Category = ' + char(39) + 'CS' + char(39) + ' 
			OR Category = ' + char(39) + 'CP' + char(39) + ' 
			OR Category = ' + char(39) + 'EC' + char(39) + ' 
			OR Category = ' + char(39) + 'FN' + char(39) + ' 
			OR Category = ' + char(39) + 'IN' + char(39) + ' 
			OR Category = ' + char(39) + 'MS' + char(39) + ' 
			OR Category = ' + char(39) + 'P' + char(39) + ' 
			OR Category = ' + char(39) + 'PD' + char(39) + ' 
			OR Category = ' + char(39) + 'SP' + char(39) + ' 
			OR Category = ' + char(39) + 'TS' + char(39) + ' 
			OR Category = ' + char(39) + 'WA' + char(39) + ' 
			OR Category = ' + char(39) + 'Products' + char(39) + ' 
			OR Category = ' + char(39) + 'CWH' + char(39) + '
			OR Category = ' + char(39) + 'RWH' + char(39) + '
			OR Category = ' + char(39) + 'TWH' + char(39) + '
			OR Category = ' + char(39) + 'SWH' + char(39) + ') as a WHERE '

if @Category != 'QWERTYASDF'
begin
set @categoryString = 'AND (Category = ' + char(39) + ''+@Category+'' + char(39) + ')'
end

if @DocumentTitle != 'QWERTYASDF'
begin
set @DocumentTitleString = 'AND (DocumentTitle LIKE ' + char(39) + '%'+@DocumentTitle+'%' + char(39) + ')'
end

if @ModelNumber != 'QWERTYASDF'
begin
set @ModelNumberString = 'AND (DocumentNumber LIKE ' + char(39) + '%'+@ModelNumber+'%' + char(39) + ')'
end

if @Filename != 'QWERTYASDF'
begin
set @FilenameString = 'AND ([Filename] LIKE ' + char(39) + '%'+@Filename+'%' + char(39) + ')'
end

if @Abstract != 'QWERTYASDF'
begin
set @AbstractString = @Abstract
end

set @sqlString2 = '((Abstract LIKE ' + char(39) + '%' + @AbstractString + '%' + char(39) + ') AND (MimeType LIKE ' + char(39) + '%' + @FileType + '%' + char(39) + ') ' + @CategoryString + @FilenameString + @ModelNumberString + @DocumentTitleString + @distributionString + ' AND (Market = ' + char(39) + 'Residential' + char(39) + ' OR Market = ' + char(39) + 'Commercial' + char(39) + '  OR Market = ' + char(39) + 'Historical' + char(39) + '  OR Market is NULL)) order by PublicationDate DESC' 

begin
exec(@sqlString + @sqlString2)

end

GO


