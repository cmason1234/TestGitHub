USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebServiceLog]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[WebServiceLog](
	[WebServiceLogID] [uniqueidentifier] NOT NULL,
	[SharedSecret] [varchar](50) NULL,
	[ServiceName] [varchar](50) NULL,
	[MethodName] [varchar](50) NULL,
	[MethodParams] [varchar](3000) NULL,
	[ResultSize] [int] NULL,
	[CreateDateTime] [datetime] NULL,
 CONSTRAINT [PK_WebServiceLog] PRIMARY KEY CLUSTERED 
(
	[WebServiceLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


END