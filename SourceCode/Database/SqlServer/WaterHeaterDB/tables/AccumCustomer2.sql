USE [WaterHeaterDB]
GO

/****** Object:  Table [dbo].[AccumCustomer2]    Script Date: 10/31/2011 15:55:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[AccumCustomer2](
	[CustNumber] [varchar](15) NOT NULL,
	[CustName] [varchar](35) NULL,
	[Addr_Line1] [varchar](35) NULL,
	[Addr_Line2] [varchar](35) NULL,
	[Addr_City] [varchar](25) NULL,
	[Addr_State] [varchar](2) NULL,
	[Addr_Zip] [varchar](10) NULL,
	[Parent] [varchar](50) NULL,
	[ParentGroup] [varchar](50) NULL,
	[SalesID] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Fax] [varchar](50) NULL,
	[CustTierID] [varchar](50) NULL,
	[CusTierDesc] [varchar](150) NULL,
	[RegionID] [varchar](50) NULL,
	[RegionDesc] [varchar](150) NULL,
	[TimeStamp] [datetime] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[AccumCustomer2] ADD  CONSTRAINT [DF_AccumCustomer2_TimeStamp]  DEFAULT (getdate()) FOR [TimeStamp]
GO

