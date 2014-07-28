Use econet;

CREATE TABLE IF NOT EXISTS messagequeuearchive(
  MessageQueueId BIGINT ,
  MessageToken VARCHAR(45) NULL ,
  UserId INT NULL ,
  UserLocationMACId INT NULL ,
  EquipmentId INT NULL ,
  MACUnpairedId INT NULL ,
  SourceAddress INT NULL ,
  DestinationAddress INT NULL ,
  MessageStatus INT NULL,
  MessageRetry INT NULL DEFAULT 0 ,
  MessageType VARCHAR(45) NULL ,
  MessageRequest VARBINARY(1024) NULL ,
  MessageResponse VARBINARY(1024) NULL ,
  ClientDateTime DATETIME NULL ,
  CreateDateTime__Gen DATETIME NULL ,
  UpdateDateTime__Gen DATETIME NULL);
  
  call rheem.CreateIndexIfNotExists('econet', 'messagequeuearchive_idx1', 'messagequeuearchive', 'UserLocationMACId', null);
	
	
