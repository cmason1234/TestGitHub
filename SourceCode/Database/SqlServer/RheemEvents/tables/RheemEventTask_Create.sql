USE [RheemEvents]
GO
/****** Object:  Table [dbo].[RheemEventTask]    Script Date: 11/17/2010 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RheemEventTask](
	[RheemEventTaskID] [uniqueidentifier] NOT NULL,
	[RheemEventID] [uniqueidentifier] NOT NULL,
	[TaskID] [uniqueidentifier] NULL,
	[DueDate] [smalldatetime] NULL,
	[IsCompleted] [int] NOT NULL,
	[CompletedDate] [smalldatetime] NULL,
	[Title] [varchar](50) NOT NULL,
 CONSTRAINT [PK_RheemEventTask] PRIMARY KEY CLUSTERED 
(
	[RheemEventTaskID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RheemEventTask]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventTask_RheemEvent] FOREIGN KEY([RheemEventID])
REFERENCES [dbo].[RheemEvent] ([RheemEventID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RheemEventTask] CHECK CONSTRAINT [FK_RheemEventTask_RheemEvent]
GO
ALTER TABLE [dbo].[RheemEventTask] CHECK CONSTRAINT [FK_RheemEventTask_Task]
GO
ALTER TABLE [dbo].[RheemEventTask] ADD  CONSTRAINT [DF_RheemEventTask_RheemEventTaskID]  DEFAULT (newid()) FOR [RheemEventTaskID]
GO
ALTER TABLE [dbo].[RheemEventTask] ADD  CONSTRAINT [DF_RheemEventTask_IsCompleted]  DEFAULT ((0)) FOR [IsCompleted]
GO
