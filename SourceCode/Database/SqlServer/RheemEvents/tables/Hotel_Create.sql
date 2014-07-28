USE [RheemEvents]
GO
/****** Object:  Table [dbo].[Hotel]    Script Date: 11/17/2010 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Hotel](
	[HotelID] [uniqueidentifier] NOT NULL,
	[HotelName] [nvarchar](250) NOT NULL,
	[AddressID] [uniqueidentifier] NOT NULL,
	[Phone] [varchar](50) NULL,
	[Fax] [varchar](50) NULL,
	[WebAddress] [varchar](150) NULL,
	[Description] [ntext] NULL,
 CONSTRAINT [PK_Hotel] PRIMARY KEY CLUSTERED 
(
	[HotelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Hotel] ADD  CONSTRAINT [DF_Hotel_HotelID]  DEFAULT (newid()) FOR [HotelID]
GO
