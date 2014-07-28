USE RheemUsers



IF OBJECTPROPERTY(OBJECT_ID('ContractorGeneratorBrands_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ContractorGeneratorBrands_Trigger
END
GO

CREATE TRIGGER ContractorGeneratorBrands_Trigger
	   ON  ContractorGeneratorBrands
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ContractorGeneratorBrands', 'RheemUsers', ContractorGeneratorBrandID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ContractorGeneratorBrands', 'RheemUsers', ContractorGeneratorBrandID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ContractorGeneratorBrands', 'RheemUsers', ContractorGeneratorBrandID from deleted
		END;
	END
GO
