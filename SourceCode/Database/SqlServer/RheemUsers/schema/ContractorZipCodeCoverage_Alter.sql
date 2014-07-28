USE [RheemUsers]
GO

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'idxCZPOrgPostal' AND object_id = OBJECT_ID('ContractorZipCodeCoverage'))
BEGIN
   CREATE NONCLUSTERED INDEX idxCZPOrgPostal ON [dbo].[ContractorZipCodeCoverage] ([OrganizationID],[PostalCode])
END
GO
