USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContractorLocatorAgreement]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ContractorLocatorAgreement]( 
		[ContractorLocatorAgreementID] [uniqueidentifier] NOT NULL, 
		[OrganizationID] [uniqueidentifier] NOT NULL, 
	    [ContractDate] [datetime] NOT NULL, 
	    [SubmittedDate] [datetime] NOT NULL,
	    [SubmittedByPersonID] [uniqueidentifier] NOT NULL, 
	    [ApprovedDate] [datetime] NULL, 
	    [ApprovedByPersonID] [uniqueidentifier] NULL, 
	    [DeniedDate] [datetime] NULL, 
	    [DeniedByPersonID] [uniqueidentifier] NULL, 
		[DeniedReason] [varchar](50) NULL,
	    [ExpirationDate] [datetime] NOT NULL,
		[Historical] [bit] NOT NULL,
		[CreateDateTime__Gen] [datetime] NULL, 
		[UpdateDateTime__Gen] [datetime] NULL, 
	CONSTRAINT [PK_ContractorLocatorAgreement] PRIMARY KEY CLUSTERED 
	( 
		[ContractorLocatorAgreementID] ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 

	ALTER TABLE [dbo].[ContractorLocatorAgreement]  WITH CHECK ADD  CONSTRAINT [FK_ContractorLocatorAgreement_Organization] FOREIGN KEY([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID])
	ALTER TABLE [dbo].[ContractorLocatorAgreement]  WITH CHECK ADD  CONSTRAINT [FK_ContractorLocatorAgreement_Person1] FOREIGN KEY([SubmittedByPersonID]) REFERENCES [dbo].[Person] ([PersonID])

END
