USE RheemDB
GO

IF OBJECTPROPERTY(OBJECT_ID('Brand_Delete'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Brand_Delete
END
GO

IF OBJECTPROPERTY(OBJECT_ID('Brand_Insert'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Brand_Insert
END
GO

IF OBJECTPROPERTY(OBJECT_ID('Brand_Update'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Brand_Update
END
GO

IF OBJECTPROPERTY(OBJECT_ID('Brand_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Brand_Trigger
END
GO

CREATE TRIGGER Brand_Trigger
	   ON  Brand
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
			 Insert RheemUsers..ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Brand', 'RheemDB', BrandID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert RheemUsers..ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Brand', 'RheemDB', BrandID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert RheemUsers..ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Brand', 'RheemDB', BrandID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('Env_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Env_Trigger
END
GO

CREATE TRIGGER Env_Trigger
	   ON  Env
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
			 Insert RheemUsers..ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Env', 'RheemDB', EnvID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert RheemUsers..ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Env', 'RheemDB', EnvID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert RheemUsers..ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Env', 'RheemDB', EnvID from deleted
		END;
	END
GO
