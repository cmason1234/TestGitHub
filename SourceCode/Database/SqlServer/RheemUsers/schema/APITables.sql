USE RheemUsers

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'APIAccessKey') AND type in (N'U'))
BEGIN
	CREATE TABLE APIAccessKey(
		APIAccessKeyID uniqueidentifier NOT NULL Default newid(),
		AccessKey varchar(50) NOT NULL,
		SecretKey varchar(256) NOT NULL,
		Active Bit NOT NULL default 0,
		KeyOwner uniqueidentifier NOT NULL,
		KeyType varchar(50) NOT NULL,
		CreateDateTime__Gen datetime NULL,
		UpdateDateTime__Gen datetime NULL,
	 CONSTRAINT PK_API_AccessKey PRIMARY KEY CLUSTERED 
	(
		APIAccessKeyID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]	
END
GO

-- ----------
-- API MASTER 
-- ----------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'APIMaster') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[APIMaster](
	[APIMasterID] [uniqueidentifier] NOT NULL Default newid(),
	[APIName] [varchar](50) NOT NULL,
	[CreateDateTime__Gen] [datetime]  NULL,
	[UpdateDateTime__Gen] [datetime]  NULL,
 CONSTRAINT [PK_APIMaster] PRIMARY KEY CLUSTERED 
(
	[APIMasterID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
	
END
GO


IF OBJECTPROPERTY(OBJECT_ID('APIMaster_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger APIMaster_Trigger
END
GO

CREATE TRIGGER APIMaster_Trigger
	   ON  APIMaster
	   AFTER INSERT, UPDATE, DELETE
	AS 
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
		
		IF EXISTS(SELECT * FROM inserted)
		BEGIN
		  IF EXISTS(SELECT * FROM deleted)
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'APIMaster', 'RheemUsers', APIMasterID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'APIMaster', 'RheemUsers', APIMasterID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'APIMaster', 'RheemUsers', APIMasterID from deleted
		END;
	    
	END
GO


-- ----------
-- API ROUTE 
-- ----------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'APIRoute') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[APIRoute](
	[APIRouteID] [uniqueidentifier] NOT NULL Default newid(),
	[APIMasterID] [uniqueidentifier] NOT NULL Constraint FK_APIRoute_APIMaster_APIMasterID
		        Foreign Key references APIMaster(APIMasterID) on delete cascade,
	[RoutePath] [varchar](1500) NOT NULL,
	[HttpMethod] [varchar](50) NOT NULL,
	[DefaultAccess] [bit] NOT NULL default 0,
	[ActionName] [varchar](200) NOT NULL,
	[CreateDateTime__Gen] [datetime]  NULL,
	[UpdateDateTime__Gen] [datetime]  NULL,
 CONSTRAINT [PK_APIRoute] PRIMARY KEY CLUSTERED 
(
	[APIRouteID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
	
END
GO


-- ------------------
-- API ROUTE TRIGGERS 
-- ------------------
IF OBJECTPROPERTY(OBJECT_ID('APIRoute_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger APIRoute_Trigger
END
GO

CREATE TRIGGER APIRoute_TRIGGER
	   ON  APIRoute
	   AFTER INSERT, UPDATE, DELETE
	AS 
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		IF EXISTS(SELECT * FROM inserted)
		BEGIN
		  IF EXISTS(SELECT * FROM deleted)
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'APIRoute', 'RheemUsers', APIRouteID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'APIRoute', 'RheemUsers', APIRouteID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'APIRoute', 'RheemUsers', APIRouteID from deleted
		END;
	    
	END
GO


-- ---------------
-- API ROUTE PARAM
-- ---------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'APIRouteParam') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[APIRouteParam](
	[APIRouteParamID] [uniqueidentifier] NOT NULL Default newid(),
	[APIRouteID] [uniqueidentifier] NOT NULL Constraint FK_APIRouteParam_APIRoute_APIRouteID
		        Foreign Key references APIRoute(APIRouteID) on delete cascade,
	[RouteName] [varchar](50) NOT NULL,
	[RouteDescription] [varchar](1500) NOT NULL,
	[ParamType] [varchar](50) NOT NULL,
	[ParamRequired] [bit] NOT NULL default 0,
	[CreateDateTime__Gen] [datetime]  NULL,
	[UpdateDateTime__Gen] [datetime]  NULL,
 CONSTRAINT [PK_APIRouteParam] PRIMARY KEY CLUSTERED 
(
	[APIRouteParamID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


END
GO


-- ---------------
-- API LOG
-- ---------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'APILog') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[APILog](
	[APILogID]  [uniqueidentifier] NOT NULL Default NewID(),
	[APIRouteParamID] [uniqueidentifier] NOT NULL Constraint FK_APILog_APIRouteParam_APIRouteParamID
		        Foreign Key references APIRouteParam(APIRouteParamID) on delete cascade,
	[APIAccessKeyID] [uniqueidentifier] NOT NULL Constraint FK_APILog_APIAccessKey_APIAccessKeyID
		        Foreign Key references APIAccessKey(APIAccessKeyID) on delete cascade,
	[ResponseSize] [int] NOT NULL default 0,
	[ResponseTime] [float] NOT NULL default 0,
	[ResponseType] [int] NOT NULL default 0,
	[CreateDateTime__Gen] [datetime]  NULL,
	[UpdateDateTime__Gen] [datetime] NULL,
 CONSTRAINT [PK_APILog] PRIMARY KEY CLUSTERED 
(
	[APILogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

END
GO

-- -----------------
-- API Access Matrix
-- -----------------
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'APIAccessMatrix') AND type in (N'U'))
BEGIN
	CREATE TABLE APIAccessMatrix(
		[APIAccessMatrixID] [uniqueidentifier] NOT NULL Default NewID(),
		[APIAccessKeyID] [uniqueidentifier] NOT NULL Constraint FK_APIAccessMatrix_APIAccessKey_APIAccessKeyID
		        Foreign Key references APIAccessKey(APIAccessKeyID) on delete cascade,
		[APIRouteID] [uniqueidentifier] NOT NULL Constraint FK_APIAccessMatrix_APIRoute_APIRouteID
		        Foreign Key references APIRoute(APIRouteID) on delete cascade,
		Method Varchar(255) NOT NULL,
		CreateDateTime__Gen datetime  NULL,
		UpdateDateTime__Gen datetime  NULL,
	 CONSTRAINT PK_APIAccessMatrix PRIMARY KEY CLUSTERED 
	(
		APIAccessMatrixID ASC
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO

-- --------------------------
-- API Access Matrix Triggers
-- --------------------------
IF OBJECTPROPERTY(OBJECT_ID('APIAccessMatrix_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger APIAccessMatrix_Trigger
END
GO

CREATE TRIGGER APIAccessMatrix_Trigger 
	   ON  APIAccessMatrix
	   AFTER INSERT, UPDATE, DELETE
	AS 
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		IF EXISTS(SELECT * FROM inserted)
		BEGIN
		  IF EXISTS(SELECT * FROM deleted)
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'APIAccessMatrix', 'RheemUsers', APIAccessMatrixID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'APIAccessMatrix', 'RheemUsers', APIAccessMatrixID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'APIAccessMatrix', 'RheemUsers', APIAccessMatrixID from deleted
		END;
	END
GO


-- -----------------------
-- API Access Key Triggers
-- -----------------------
IF OBJECTPROPERTY(OBJECT_ID('APIAccessKey_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger APIAccessKey_Trigger
END
GO

CREATE TRIGGER APIAccessKey_Trigger 
	   ON  APIAccessKey
	   AFTER INSERT, UPDATE, DELETE
	AS 
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;
	
		IF EXISTS(SELECT * FROM inserted)
		BEGIN
		  IF EXISTS(SELECT * FROM deleted)
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'APIAccessKey', 'RheemUsers', APIAccessKeyID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'APIAccessKey', 'RheemUsers', APIAccessKeyID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'APIAccessKey', 'RheemUsers', APIAccessKeyID from deleted
		END;
	    
	END
GO




