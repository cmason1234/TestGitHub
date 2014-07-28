USE RheemUsers

GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'SystemMonitorMetric') AND type in (N'U'))
BEGIN

	CREATE TABLE SystemMonitorMetric(
	    SystemMonitorMetricID uniqueIdentifier not Null default newid(),
		MetricName varchar(200) NOT NULL,
		MetricValue varchar(4000) NOT NULL,
		MetricUnitsOfMeasure varchar(200) NOT NULL,
		CreateDateTime__Gen datetime NULL,
		UpdateDateTime__Gen datetime NULL,
	 CONSTRAINT PK_SystemMonitorMetric PRIMARY KEY CLUSTERED 
	(
		SystemMonitorMetricID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE SystemMonitorMetric ADD CONSTRAINT [UK_SystemMonitorMetric] UNIQUE NONCLUSTERED ([MetricName])
END
GO
