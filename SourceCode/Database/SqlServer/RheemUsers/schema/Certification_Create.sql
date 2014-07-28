USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Certification]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[Certification]( 
		[CertificationID] [uniqueidentifier] NOT NULL, 
		[DisplayName] [varchar](50) NOT NULL,
		[ExternalURL] [varchar](256) NULL,
	CONSTRAINT [PK_Certification] PRIMARY KEY CLUSTERED 
	( 
		[CertificationID] ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 

END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductCertification]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ProductCertification]( 
		[ProductCertificationID] [uniqueidentifier] NOT NULL, 
		[ProductID] [uniqueidentifier] NOT NULL,
		[CertificationID] [uniqueidentifier] NOT NULL,
	CONSTRAINT [PK_ProductCertification] PRIMARY KEY CLUSTERED 
	( 
		[ProductCertificationID] ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 
ALTER TABLE [dbo].[ProductCertification]  WITH CHECK ADD  CONSTRAINT [FK_ProductCertification_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID]) ON DELETE CASCADE
ALTER TABLE [dbo].[ProductCertification]  WITH CHECK ADD  CONSTRAINT [FK_ProductCertification_Certification] FOREIGN KEY([CertificationID])
REFERENCES [dbo].[Certification] ([CertificationID]) ON DELETE CASCADE
END
GO
