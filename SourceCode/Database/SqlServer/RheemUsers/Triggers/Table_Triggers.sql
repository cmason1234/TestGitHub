USE RheemUsers


IF OBJECTPROPERTY(OBJECT_ID('Organization_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Organization_Trigger
END
GO

CREATE TRIGGER Organization_Trigger
	   ON  Organization
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Organization', 'RheemUsers', OrganizationID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Organization', 'RheemUsers', OrganizationID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Organization', 'RheemUsers', OrganizationID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('Address_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Address_Trigger
END
GO

CREATE TRIGGER Address_Trigger
	   ON  Address
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Address', 'RheemUsers', AddressID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Address', 'RheemUsers', AddressID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Address', 'RheemUsers', AddressID from deleted
		END;
	END
GO


IF OBJECTPROPERTY(OBJECT_ID('Person_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Person_Trigger
END
GO

CREATE TRIGGER Person_Trigger
	   ON  Person
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Person', 'RheemUsers', PersonID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Person', 'RheemUsers', PersonID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Person', 'RheemUsers', PersonID from deleted
		END;
	END
GO


IF OBJECTPROPERTY(OBJECT_ID('PersonBrand_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger PersonBrand_Trigger
END
GO

CREATE TRIGGER PersonBrand_Trigger
	   ON  PersonBrand
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'PersonBrand', 'RheemUsers', PersonBrandID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'PersonBrand', 'RheemUsers', PersonBrandID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'PersonBrand', 'RheemUsers', PersonBrandID from deleted
		END;
	END
GO


IF OBJECTPROPERTY(OBJECT_ID('OrganizationBrand_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger OrganizationBrand_Trigger
END
GO

CREATE TRIGGER OrganizationBrand_Trigger
	   ON  OrganizationBrand
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'OrganizationBrand', 'RheemUsers', OrganizationBrandID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'OrganizationBrand', 'RheemUsers', OrganizationBrandID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'OrganizationBrand', 'RheemUsers', OrganizationBrandID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('DistributorOrganization_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger DistributorOrganization_Trigger
END
GO

CREATE TRIGGER DistributorOrganization_Trigger
	   ON  DistributorOrganization
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'DistributorOrganization', 'RheemUsers', DistributorOrganizationID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'DistributorOrganization', 'RheemUsers', DistributorOrganizationID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'DistributorOrganization', 'RheemUsers', DistributorOrganizationID from deleted
		END;
	END
GO
 
IF OBJECTPROPERTY(OBJECT_ID('ContractorAC_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ContractorAC_Trigger
END
GO

CREATE TRIGGER ContractorAC_Trigger
	   ON  ContractorAC
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ContractorAC', 'RheemUsers', ContractorACID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ContractorAC', 'RheemUsers', ContractorACID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ContractorAC', 'RheemUsers', ContractorACID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ContractorOrganization_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ContractorOrganization_Trigger
END
GO

CREATE TRIGGER ContractorOrganization_Trigger
	   ON  ContractorOrganization
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ContractorOrganization', 'RheemUsers', ContractorOrganizationID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ContractorOrganization', 'RheemUsers', ContractorOrganizationID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ContractorOrganization', 'RheemUsers', ContractorOrganizationID from deleted
		END;
	END
GO


IF OBJECTPROPERTY(OBJECT_ID('JobFunction_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger JobFunction_Trigger
END
GO

CREATE TRIGGER JobFunction_Trigger
	   ON  JobFunction
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'JobFunction', 'RheemUsers', JobFunctionID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'JobFunction', 'RheemUsers', JobFunctionID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'JobFunction', 'RheemUsers', JobFunctionID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('Department_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Department_Trigger
END
GO

CREATE TRIGGER Department_Trigger
	   ON  Department
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Department', 'RheemUsers', DepartmentID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Department', 'RheemUsers', DepartmentID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Department', 'RheemUsers', DepartmentID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('PersonDepartmentJob_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger PersonDepartmentJob_Trigger
END
GO

CREATE TRIGGER PersonDepartmentJob_Trigger
	   ON  PersonDepartmentJob
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'PersonDepartmentJob', 'RheemUsers', PersonDepartmentJobID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'PersonDepartmentJob', 'RheemUsers', PersonDepartmentJobID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'PersonDepartmentJob', 'RheemUsers', PersonDepartmentJobID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('DepartmentJobFunction_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger DepartmentJobFunction_Trigger
END
GO

CREATE TRIGGER DepartmentJobFunction_Trigger
	   ON  DepartmentJobFunction
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'DepartmentJobFunction', 'RheemUsers', DepartmentJobFunctionID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'DepartmentJobFunction', 'RheemUsers', DepartmentJobFunctionID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'DepartmentJobFunction', 'RheemUsers', DepartmentJobFunctionID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('Country_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Country_Trigger
END
GO

CREATE TRIGGER Country_Trigger
	   ON  Country
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Country', 'RheemUsers', CountryID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Country', 'RheemUsers', CountryID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Country', 'RheemUsers', CountryID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ProductCategory_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ProductCategory_Trigger
END
GO

CREATE TRIGGER ProductCategory_Trigger
	   ON  ProductCategory
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ProductCategory', 'RheemUsers', ProductCategoryID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ProductCategory', 'RheemUsers', ProductCategoryID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ProductCategory', 'RheemUsers', ProductCategoryID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ProductGroup_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ProductGroup_Trigger
END
GO

CREATE TRIGGER ProductGroup_Trigger
	   ON  ProductGroup
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ProductGroup', 'RheemUsers', ProductGroupID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ProductGroup', 'RheemUsers', ProductGroupID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ProductGroup', 'RheemUsers', ProductGroupID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ProductProductGroup_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ProductProductGroup_Trigger
END
GO

CREATE TRIGGER ProductProductGroup_Trigger
	   ON  ProductProductGroup
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ProductProductGroup', 'RheemUsers', ProductProductGroupID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ProductProductGroup', 'RheemUsers', ProductProductGroupID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ProductProductGroup', 'RheemUsers', ProductProductGroupID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('Product_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Product_Trigger
END
GO

CREATE TRIGGER Product_Trigger
	   ON  Product
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Product', 'RheemUsers', ProductID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Product', 'RheemUsers', ProductID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Product', 'RheemUsers', ProductID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ContractorWaterHeater_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ContractorWaterHeater_Trigger
END
GO

CREATE TRIGGER ContractorWaterHeater_Trigger
	   ON  ContractorWaterHeater
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ContractorWaterHeater', 'RheemUsers', ContractorWaterHeaterID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ContractorWaterHeater', 'RheemUsers', ContractorWaterHeaterID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ContractorWaterHeater', 'RheemUsers', ContractorWaterHeaterID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ContractorPoolSpa_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ContractorPoolSpa_Trigger
END
GO

CREATE TRIGGER ContractorPoolSpa_Trigger
	   ON  ContractorPoolSpa
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ContractorPoolSpa', 'RheemUsers', ContractorPoolSpaID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ContractorPoolSpa', 'RheemUsers', ContractorPoolSpaID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ContractorPoolSpa', 'RheemUsers', ContractorPoolSpaID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ContractorGenerator_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ContractorGenerator_Trigger
END
GO

CREATE TRIGGER ContractorGenerator_Trigger
	   ON  ContractorGenerator
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ContractorGenerator', 'RheemUsers', ContractorGeneratorID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ContractorGenerator', 'RheemUsers', ContractorGeneratorID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ContractorGenerator', 'RheemUsers', ContractorGeneratorID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('RebateProgramMember_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger RebateProgramMember_Trigger
END
GO

CREATE TRIGGER RebateProgramMember_Trigger
	   ON  RebateProgramMember
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'RebateProgramMember', 'RheemUsers', RebateProgramMemberID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'RebateProgramMember', 'RheemUsers', RebateProgramMemberID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'RebateProgramMember', 'RheemUsers', RebateProgramMemberID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('RebateProgram_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger RebateProgram_Trigger
END
GO

CREATE TRIGGER RebateProgram_Trigger
	   ON  RebateProgram
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'RebateProgram', 'RheemUsers', RebateProgramID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'RebateProgram', 'RheemUsers', RebateProgramID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'RebateProgram', 'RheemUsers', RebateProgramID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ContractorRetail_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ContractorRetail_Trigger
END
GO

CREATE TRIGGER ContractorRetail_Trigger
	   ON  ContractorRetail
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ContractorRetail', 'RheemUsers', ContractorRetailID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ContractorRetail', 'RheemUsers', ContractorRetailID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ContractorRetail', 'RheemUsers', ContractorRetailID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ContractorZipCodeCoverage_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ContractorZipCodeCoverage_Trigger
END
GO

CREATE TRIGGER ContractorZipCodeCoverage_Trigger
	   ON  ContractorZipCodeCoverage
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ContractorZipCodeCoverage', 'RheemUsers', ContractorZipCodeCoverageID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ContractorZipCodeCoverage', 'RheemUsers', ContractorZipCodeCoverageID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ContractorZipCodeCoverage', 'RheemUsers', ContractorZipCodeCoverageID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('Application_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Application_Trigger
END
GO

CREATE TRIGGER Application_Trigger
	   ON  Application
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Application', 'RheemUsers', ApplicationID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Application', 'RheemUsers', ApplicationID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Application', 'RheemUsers', ApplicationID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('Role_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Role_Trigger
END
GO

CREATE TRIGGER Role_Trigger
	   ON  Role
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Role', 'RheemUsers', RoleID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Role', 'RheemUsers', RoleID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Role', 'RheemUsers', RoleID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ApplicationRole_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ApplicationRole_Trigger
END
GO

CREATE TRIGGER ApplicationRole_Trigger
	   ON  ApplicationRole
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ApplicationRole', 'RheemUsers', ApplicationRoleID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ApplicationRole', 'RheemUsers', ApplicationRoleID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ApplicationRole', 'RheemUsers', ApplicationRoleID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('PersonRole_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger PersonRole_Trigger
END
GO

CREATE TRIGGER PersonRole_Trigger
	   ON  PersonRole
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'PersonRole', 'RheemUsers', PersonRoleID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'PersonRole', 'RheemUsers', PersonRoleID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'PersonRole', 'RheemUsers', PersonRoleID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('SpecialPage_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger SpecialPage_Trigger
END
GO

CREATE TRIGGER SpecialPage_Trigger
	   ON  SpecialPage
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'SpecialPage', 'RheemUsers', SpecialPageID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'SpecialPage', 'RheemUsers', SpecialPageID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'SpecialPage', 'RheemUsers', SpecialPageID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('CloudDocument_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger CloudDocument_Trigger
END
GO

CREATE TRIGGER CloudDocument_Trigger
	   ON  CloudDocument
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'CloudDocument', 'RheemUsers', CloudDocumentID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'CloudDocument', 'RheemUsers', CloudDocumentID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'CloudDocument', 'RheemUsers', CloudDocumentID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('CloudImage_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger CloudImage_Trigger
END
GO

CREATE TRIGGER CloudImage_Trigger
	   ON  CloudImage
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'CloudImage', 'RheemUsers', CloudImageID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'CloudImage', 'RheemUsers', CloudImageID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'CloudImage', 'RheemUsers', CloudImageID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ProductModel_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ProductModel_Trigger
END
GO

CREATE TRIGGER ProductModel_Trigger
	   ON  ProductModel
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ProductModel', 'RheemUsers', ProductModelID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ProductModel', 'RheemUsers', ProductModelID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ProductModel', 'RheemUsers', ProductModelID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('PersonOrganization_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger PersonOrganization_Trigger
END
GO

CREATE TRIGGER PersonOrganization_Trigger
	   ON  PersonOrganization
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'PersonOrganization', 'RheemUsers', PersonOrganizationID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'PersonOrganization', 'RheemUsers', PersonOrganizationID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'PersonOrganization', 'RheemUsers', PersonOrganizationID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('OrganizationParent_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger OrganizationParent_Trigger
END
GO

CREATE TRIGGER OrganizationParent_Trigger
	   ON  OrganizationParent
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'OrganizationParent', 'RheemUsers', OrganizationParentID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'OrganizationParent', 'RheemUsers', OrganizationParentID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'OrganizationParent', 'RheemUsers', OrganizationParentID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('Certification_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Certification_Trigger
END
GO

CREATE TRIGGER Certification_Trigger
	   ON  Certification
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Certification', 'RheemUsers', CertificationID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Certification', 'RheemUsers', CertificationID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Certification', 'RheemUsers', CertificationID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ProductCertification_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ProductCertification_Trigger
END
GO

CREATE TRIGGER ProductCertification_Trigger
	   ON  ProductCertification
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ProductCertification', 'RheemUsers', ProductCertificationID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ProductCertification', 'RheemUsers', ProductCertificationID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ProductCertification', 'RheemUsers', ProductCertificationID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('OrganizationAddress_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger OrganizationAddress_Trigger
END
GO

CREATE TRIGGER OrganizationAddress_Trigger
	   ON  OrganizationAddress
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'OrganizationAddress', 'RheemUsers', OrganizationAddressID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'OrganizationAddress', 'RheemUsers', OrganizationAddressID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'OrganizationAddress', 'RheemUsers', OrganizationAddressID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ContractorRetailPreferredDistributor_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ContractorRetailPreferredDistributor_Trigger
END
GO

CREATE TRIGGER ContractorRetailPreferredDistributor_Trigger
	   ON  ContractorRetailPreferredDistributor
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ContractorRetailPreferredDistributor', 'RheemUsers', ContractorRetailPreferredDistributorID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ContractorRetailPreferredDistributor', 'RheemUsers', ContractorRetailPreferredDistributorID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ContractorRetailPreferredDistributor', 'RheemUsers', ContractorRetailPreferredDistributorID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('DistributorCatalogPricingNames_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger DistributorCatalogPricingNames_Trigger
END
GO

CREATE TRIGGER DistributorCatalogPricingNames_Trigger
	   ON  DistributorCatalogPricingNames
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'DistributorCatalogPricingNames', 'RheemUsers', DistributorCatalogPricingNamesID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'DistributorCatalogPricingNames', 'RheemUsers', DistributorCatalogPricingNamesID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'DistributorCatalogPricingNames', 'RheemUsers', DistributorCatalogPricingNamesID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ModelWarrantyRule_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ModelWarrantyRule_Trigger
END
GO

CREATE TRIGGER ModelWarrantyRule_Trigger
	   ON  ModelWarrantyRule
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ModelWarrantyRule', 'RheemUsers', ModelWarrantyRuleID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ModelWarrantyRule', 'RheemUsers', ModelWarrantyRuleID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ModelWarrantyRule', 'RheemUsers', ModelWarrantyRuleID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ModelWarrantyRuleModel_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ModelWarrantyRuleModel_Trigger
END
GO

CREATE TRIGGER ModelWarrantyRuleModel_Trigger
	   ON  ModelWarrantyRuleModel
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ModelWarrantyRuleModel', 'RheemUsers', ModelWarrantyRuleModelID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ModelWarrantyRuleModel', 'RheemUsers', ModelWarrantyRuleModelID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ModelWarrantyRuleModel', 'RheemUsers', ModelWarrantyRuleModelID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('RheemWebSite_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger RheemWebSite_Trigger
END
GO

CREATE TRIGGER RheemWebSite_Trigger
	   ON  RheemWebSite
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'RheemWebSite', 'RheemUsers', RheemWebSiteID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'RheemWebSite', 'RheemUsers', RheemWebSiteID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'RheemWebSite', 'RheemUsers', RheemWebSiteID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('Lists_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Lists_Trigger
END
GO

CREATE TRIGGER Lists_Trigger
	   ON  Lists
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Lists', 'RheemUsers', ListID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Lists', 'RheemUsers', ListID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Lists', 'RheemUsers', ListID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ListUserList_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ListUserList_Trigger
END
GO

CREATE TRIGGER ListUserList_Trigger
	   ON  ListUserList
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ListUserList', 'RheemUsers', ListUserListID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ListUserList', 'RheemUsers', ListUserListID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ListUserList', 'RheemUsers', ListUserListID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ListEmailAddress_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ListEmailAddress_Trigger
END
GO

CREATE TRIGGER ListEmailAddress_Trigger
	   ON  ListEmailAddress
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ListEmailAddress', 'RheemUsers', ListEmailAddressID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ListEmailAddress', 'RheemUsers', ListEmailAddressID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ListEmailAddress', 'RheemUsers', ListEmailAddressID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('HTMLTemplates_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger HTMLTemplates_Trigger
END
GO

CREATE TRIGGER HTMLTemplates_Trigger
	   ON  HTMLTemplates
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'HTMLTemplates', 'RheemUsers', HTMLTemplateID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'HTMLTemplates', 'RheemUsers', HTMLTemplateID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'HTMLTemplates', 'RheemUsers', HTMLTemplateID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('CatalogAddendum_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger CatalogAddendum_Trigger
END
GO

CREATE TRIGGER CatalogAddendum_Trigger
	   ON  CatalogAddendum
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'CatalogAddendum', 'RheemUsers', CatalogAddendumID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'CatalogAddendum', 'RheemUsers', CatalogAddendumID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'CatalogAddendum', 'RheemUsers', CatalogAddendumID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('Menu_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger Menu_Trigger
END
GO

CREATE TRIGGER Menu_Trigger
	   ON  Menu
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'Menu', 'RheemUsers', MenuID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'Menu', 'RheemUsers', MenuID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'Menu', 'RheemUsers', MenuID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ProductTag_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ProductTag_Trigger
END
GO

CREATE TRIGGER ProductTag_Trigger
	   ON  ProductTag
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ProductTag', 'RheemUsers', ProductTagID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ProductTag', 'RheemUsers', ProductTagID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ProductTag', 'RheemUsers', ProductTagID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('ProductProductTag_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger ProductProductTag_Trigger
END
GO

CREATE TRIGGER ProductProductTag_Trigger
	   ON  ProductProductTag
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'ProductProductTag', 'RheemUsers', ProductProductTagID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'ProductProductTag', 'RheemUsers', ProductProductTagID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'ProductProductTag', 'RheemUsers', ProductProductTagID from deleted
		END;
	END
GO

IF OBJECTPROPERTY(OBJECT_ID('AdMakerImage_Trigger'), 'IsTrigger') = 1
BEGIN
  Drop Trigger AdMakerImage_Trigger
END
GO

CREATE TRIGGER AdMakerImage_Trigger
	   ON  AdMakerImage
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
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'UPDATE', 'AdMakerImage', 'RheemUsers', AdMakerImageID from Inserted
		  END
		  ELSE
		  BEGIN
			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'INSERT', 'AdMakerImage', 'RheemUsers', AdMakerImageID from Inserted
		  END
		END
		ELSE
		BEGIN
  			 Insert ReplicationLog(typeName, tableName, DbName, pkid) SELECT 'DELETE', 'AdMakerImage', 'RheemUsers', AdMakerImageID from deleted
		END;
	END
GO