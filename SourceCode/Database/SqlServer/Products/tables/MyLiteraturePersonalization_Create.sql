USE [Products]
GO

/****** Object:  Table [dbo].[MyLiteraturePersonalization]    Script Date: 06/14/2011 18:20:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MyLiteraturePersonalization](
	MyLiteraturePersonalizationID uniqueidentifier NOT NULL,
	LiteratureRequestID uniqueidentifier NOT NULL,
    OrganizationFileID uniqueidentifier NULL,
	OrganizationName varchar(128) NULL,
	AddressLine1 varchar(50) NULL,
	City varchar(50) NULL,
	State varchar(3) NULL,
	PostalCode varchar(50) NULL,
	Phone varchar(50) NULL,
    CONSTRAINT [PK_MyLiteraturePersonalization] PRIMARY KEY CLUSTERED 
(
	[MyLiteraturePersonalizationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
