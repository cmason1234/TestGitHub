USE [rheemusers]

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'DocumentType') AND type in (N'U'))
BEGIN
	CREATE TABLE DocumentType( 
		[DocumentTypeID] [uniqueidentifier] NOT NULL, 
		[TypeName] [varchar](100) NOT NULL,
	CONSTRAINT [PK_DocumentType] PRIMARY KEY CLUSTERED 
	( 
		[DocumentTypeID] ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 

	ALTER TABLE DocumentType ADD CONSTRAINT [UK_DocumentType] UNIQUE NONCLUSTERED ([TypeName])

	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Advertising Photo')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Category Lifestyle')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Consumer Literature')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Gallery')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Advertising Photo')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Consumer Literature')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Installation Instructions')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Installations Instructions')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Low-Res Photo')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Sales Fact Sheet')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Sales Fact Sheets')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Specification  Sheets')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Specification Sheet')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Specification Sheets')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Submittal Sheets')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Tax Credit Form')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical Thumbnail')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Historical WebPhoto')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Installation Instruction')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Installation Instructions')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'JPG')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Low-Res Photo')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Hi-Res Photo')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Parts List Historical')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Print Product Image')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Sales Fact  Sheets')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Sales Fact Sheets')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Special Literature Order Form')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Specification Sheet')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Specification Sheets')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Submittal  Sheets')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Submittal Sheets')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Tax Credit Form')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Thumbnail')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Use & Care Instructions')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Use and Care Instructions')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'WebPhoto')
	INSERT INTO RheemUsers..DocumentType (DocumentTypeId, TypeName) values (NEWID(), 'Web Product Image')

END

if NOT EXISTS(select * from sys.columns where Name = N'DocumentTypeID'  
            and Object_ID = Object_ID(N'CloudDocument'))
 BEGIN
    ALTER TABLE CloudDocument ADD DocumentTypeID uniqueidentifier NULL
	ALTER TABLE CloudDocument ADD CONSTRAINT FK_CloudDocument_DocumentTypeID FOREIGN KEY 
        (DocumentTypeID) REFERENCES DocumentType(DocumentTypeID) on delete cascade
	exec('update CloudDocument set DocumentTypeID = (Select DocumentTypeID from DocumentType where TypeName=''Web Product Image'')')
END


if NOT EXISTS(select * from sys.columns where Name = N'CreateDateTime__Gen'  
            and Object_ID = Object_ID(N'CloudDocument'))
BEGIN
  ALTER TABLE CloudDocument ADD CreateDateTime__Gen DateTime NULL
  exec(' update CloudDocument  set CreateDateTime__Gen = SYSDATETIME()')
END

if NOT EXISTS(select * from sys.columns where Name = N'UpdateDateTime__Gen'  
            and Object_ID = Object_ID(N'CloudDocument'))
BEGIN
    ALTER TABLE CloudDocument ADD UpdateDateTime__Gen DateTime NULL
	exec('update CloudDocument  set UpdateDateTime__Gen = SYSDATETIME()')
END
if NOT EXISTS(select * from sys.columns where Name = N'DocumentTitle'  
            and Object_ID = Object_ID(N'CloudDocument'))
  ALTER TABLE CloudDocument alter column DocumentTitle Varchar(256) 
  
if NOT EXISTS(select * from sys.columns where Name = N'FriendlyName'  
            and Object_ID = Object_ID(N'CloudDocument'))  
  ALTER TABLE CloudDocument alter column FriendlyName Varchar(256)
