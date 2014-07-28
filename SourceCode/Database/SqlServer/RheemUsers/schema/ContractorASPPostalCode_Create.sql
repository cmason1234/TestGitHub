USE [RheemUsers]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContractorASPPostalCode]') AND type in (N'U'))
BEGIN

	CREATE TABLE [dbo].[ContractorASPPostalCode](
		[ContractorASPPostalCodeID] [uniqueidentifier] NOT NULL,
		[OrganizationID] [uniqueidentifier] NOT NULL,
		[PostalCode] [varchar](50) NOT NULL,
	CONSTRAINT [PK_ContractorASPPostalCode] PRIMARY KEY CLUSTERED
	(
		[ContractorASPPostalCodeID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE [dbo].[ContractorASPPostalCode]  WITH CHECK ADD  CONSTRAINT [FK_ContractorASPPostalCode_Organization] FOREIGN KEY([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID]) ON DELETE CASCADE

END
