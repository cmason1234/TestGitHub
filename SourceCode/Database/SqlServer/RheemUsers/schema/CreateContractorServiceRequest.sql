USE [RheemUsers]
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DealerRequest]') AND type in (N'U'))
DROP TABLE [dbo].[DealerRequest]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContractorServiceRequest]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[ContractorServiceRequest](
		[ContractorServiceRequestID] [uniqueidentifier] NOT NULL,
		[OrganizationID] [uniqueidentifier] NOT NULL,
		[SourceSite] [varchar](50) NULL,
		[SourceURL] [varchar](500) NULL,
		[DealerRank] [int] NULL,
		[FirstName] [varchar](50) NULL,
		[LastName] [varchar](50) NULL,
		[EmailAddress] [varchar](150) NULL,
		[Phone] [varchar](50) NULL,
		[City] [varchar](50) NULL,
		[State] [varchar](50) NULL,
		[Zip] [varchar](50) NULL,
		[Comments] [varchar](1500) NULL,
		[RequestDate] [smalldatetime] NULL,
		[RequestStatus] [int] NULL,
		[RequestDateConnected] [smalldatetime] NULL,
	 CONSTRAINT [PK_DealerRequest] PRIMARY KEY CLUSTERED 
	(
		[ContractorServiceRequestID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE [dbo].[ContractorServiceRequest] ADD  CONSTRAINT [DF_ContractorServiceRequest_ContractorServiceRequestID]  DEFAULT (newid()) FOR [ContractorServiceRequestID]
END
GO
