USE Products


IF OBJECTPROPERTY(OBJECT_ID('ProductDocument_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ProductDocument_Trigger
END
GO

CREATE TRIGGER ProductDocument_Trigger
	   ON  ProductDocument
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
			 Insert rheemusers..ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ProductDocument', 'Products', ProductDocumentID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert rheemusers..ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ProductDocument', 'Products', ProductDocumentID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert rheemusers..ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ProductDocument', 'Products', ProductDocumentID from deleted
		END;
	END
GO
