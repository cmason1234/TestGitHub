USE [rheemusers]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContractorRetailPreferredDistributor]') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[ContractorRetailPreferredDistributor](
	[ContractorRetailPreferredDistributorID] [uniqueidentifier] NOT NULL,
	[OrganizationIDContractor] [uniqueidentifier] NOT NULL,
	[OrganizationIDDistributor] [uniqueidentifier] NOT NULL,
	[CreateDateTime__Gen] [datetime] NULL,
	[UpdateDateTime__Gen] [datetime] NULL,
 CONSTRAINT [PK_ContractorRetailPreferredDistributor] PRIMARY KEY CLUSTERED 
(
	[ContractorRetailPreferredDistributorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END
GO