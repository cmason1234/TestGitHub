USE [RheemEvents]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[CollateralType](
	[CollateralTypeID] [uniqueidentifier] NOT NULL,
	[CollateralType] [varchar](150) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_CollateralType] PRIMARY KEY CLUSTERED
(
	[CollateralTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

CREATE UNIQUE INDEX UK1_CollateralType ON [dbo].[CollateralType](CollateralType)
GO


