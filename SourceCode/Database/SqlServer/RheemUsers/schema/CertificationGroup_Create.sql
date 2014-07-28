USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CertificationGroup]') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[CertificationGroup](
   [CertificationGroupID] [uniqueidentifier] NOT NULL,
   [GroupName] [varchar](50) NULL,
   [CreateDateTime__Gen] [datetime] NULL,
   [UpdateDateTime__Gen] [datetime] NULL,
   CONSTRAINT [PK_CertificationGroup] PRIMARY KEY CLUSTERED 
(
	[CertificationGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
	CONSTRAINT [UK_CertificationGroup] UNIQUE (GroupName)
) ON [PRIMARY]

END
GO

IF OBJECTPROPERTY(OBJECT_ID('CertificationGroup_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger CertificationGroup_Trigger
END
GO

CREATE TRIGGER CertificationGroup_Trigger
	   ON  CertificationGroup
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'CertificationGroup', 'RheemUsers', CertificationGroupID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'CertificationGroup', 'RheemUsers', CertificationGroupID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'CertificationGroup', 'RheemUsers', CertificationGroupID from deleted
		END;
	END
GO


IF NOT EXISTS(SELECT * FROM CertificationGroup)
BEGIN
	INSERT INTO CertificationGroup(CertificationGroupID, GroupName, CreateDateTime__Gen, UpdateDateTime__Gen) VALUES
	  (newid(), 'Certifications', sysdatetime(), sysdatetime())
END
GO

IF NOT EXISTS(SELECT * FROM sys.columns WHERE [name] = N'CertificationGroupID' 
         AND [object_id] = OBJECT_ID(N'Certification'))
BEGIN
    -- Column Does NOT Exist
	ALTER TABLE Certification ADD CertificationGroupID uniqueidentifier 
	ALTER TABLE Certification add constraint Certification_FK1 
	     FOREIGN KEY ( CertificationGroupID ) references CertificationGroup(CertificationGroupID)
	exec('Update Certification set CertificationGroupID = (select CertificationGroupID from CertificationGroup where GroupName=''Certifications'')')
	ALTER Table Certification ALTER COLUMN CertificationGroupID uniqueidentifier NOT NULL
END
GO

