USE RCN


IF OBJECTPROPERTY(OBJECT_ID('Document_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Document_Trigger
END
GO

CREATE TRIGGER Document_Trigger
	   ON  Document
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
			 Insert rheemusers..ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Document', 'RCN', DocumentID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert rheemusers..ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Document', 'RCN', DocumentID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert rheemusers..ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Document', 'RCN', DocumentID from deleted
		END;
	END
GO
