USE [RheemUsers]
GO
/****** Object:  Table [dbo].[CallQueue]    Script Date: 09/27/2012 07:50:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallQueue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CallQueue](
	[CallQueueID] [uniqueidentifier] NOT NULL,
	[ZipCode] [varchar](50) NULL,
	[ContractorID] [uniqueidentifier] NULL,
	[CallStatus] [varchar](50) NULL,
	[Source] [varchar](50) NULL,
	[ConsumerNumber] [varchar](50) NULL,
	[GasService] [int] NULL,
	[Bathrooms] [int] NULL,
	[Showers] [int] NULL,
	[Tubs] [int] NULL,
	[Sinks] [int] NULL,
	[CreateDateTime__Gen] [datetime] NULL,
	[UpdateDateTime__Gen] [datetime] NULL,
 CONSTRAINT [PK_CallQueue] PRIMARY KEY CLUSTERED 
(
	[CallQueueID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF_CallQueue_GasService]    Script Date: 09/27/2012 07:50:15 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_CallQueue_GasService]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallQueue]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CallQueue_GasService]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CallQueue] ADD  CONSTRAINT [DF_CallQueue_GasService]  DEFAULT ((0)) FOR [GasService]
END


End
GO
/****** Object:  Default [DF_CallQueue_Bathrooms]    Script Date: 09/27/2012 07:50:15 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_CallQueue_Bathrooms]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallQueue]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CallQueue_Bathrooms]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CallQueue] ADD  CONSTRAINT [DF_CallQueue_Bathrooms]  DEFAULT ((0)) FOR [Bathrooms]
END


End
GO
/****** Object:  Default [DF_CallQueue_Showers]    Script Date: 09/27/2012 07:50:15 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_CallQueue_Showers]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallQueue]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CallQueue_Showers]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CallQueue] ADD  CONSTRAINT [DF_CallQueue_Showers]  DEFAULT ((0)) FOR [Showers]
END


End
GO
/****** Object:  Default [DF_CallQueue_Tubs]    Script Date: 09/27/2012 07:50:15 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_CallQueue_Tubs]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallQueue]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CallQueue_Tubs]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CallQueue] ADD  CONSTRAINT [DF_CallQueue_Tubs]  DEFAULT ((0)) FOR [Tubs]
END


End
GO
/****** Object:  Default [DF_CallQueue_Sinks]    Script Date: 09/27/2012 07:50:15 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_CallQueue_Sinks]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallQueue]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CallQueue_Sinks]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CallQueue] ADD  CONSTRAINT [DF_CallQueue_Sinks]  DEFAULT ((0)) FOR [Sinks]
END


End
GO
