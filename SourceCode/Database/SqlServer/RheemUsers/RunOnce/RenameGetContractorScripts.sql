USE rheemusers
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetContractorACByZipCode') AND type in (N'P', N'PC'))
  exec SP_RENAME  'GetContractorACByZipCode', 'DELETEGetContractorACByZipCode'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetContractorACByZipCode2010') AND type in (N'P', N'PC'))
  exec SP_RENAME   'GetContractorACByZipCode2010', 'DELETEGetContractorACByZipCode2010'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetContractorACByZipCodeTemp') AND type in (N'P', N'PC'))
  exec SP_RENAME   'GetContractorACByZipCodeTemp', 'DELETEGetContractorACByZipCodeTemp'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetContractorWHByZipCode') AND type in (N'P', N'PC'))
  exec SP_RENAME   'GetContractorWHByZipCode', 'DELETEGetContractorWHByZipCode'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetContractorWHByZipCode2010') AND type in (N'P', N'PC'))
  exec SP_RENAME   'GetContractorWHByZipCode2010', 'DELETEGetContractorWHByZipCode2010'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetContractorGeneratorByZipCode') AND type in (N'P', N'PC'))
  exec SP_RENAME   'GetContractorGeneratorByZipCode', 'DELETEGetContractorGeneratorByZipCode'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetContractorGeneratorByZipCode2010') AND type in (N'P', N'PC'))
  exec SP_RENAME   'GetContractorGeneratorByZipCode2010', 'DELETEGetContractorGeneratorByZipCode2010'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetContractorPoolSparByZipCode') AND type in (N'P', N'PC'))
  exec SP_RENAME   'GetContractorPoolSparByZipCode', 'DELETEGetContractorPoolSparByZipCode'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'GetContractorPoolSpaByZipCode2010') AND type in (N'P', N'PC'))
  exec SP_RENAME   'GetContractorPoolSpaByZipCode2010', 'DELETEGetContractorPoolSpaByZipCode2010'
GO
