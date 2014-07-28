USE [RheemEvents]
GO
/****** Object:  Table [dbo].[Task]    Script Date: 11/17/2010 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Task](
	[TaskID] [uniqueidentifier] NOT NULL,
	[EventType] [varchar](50) NULL,
	[TaskOrder] [int] NOT NULL,
	[Title] [nvarchar](50) NULL,
	[DaysPrior] [int] NOT NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Task_TaskID]  DEFAULT (newid()) FOR [TaskID]
GO
ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Task_TaskOrder]  DEFAULT ((0)) FOR [TaskOrder]
GO
ALTER TABLE [dbo].[Task] ADD  CONSTRAINT [DF_Task_DaysPrior]  DEFAULT ((0)) FOR [DaysPrior]
GO
