Use econet;

CREATE TABLE IF NOT EXISTS messagequeue(
  MessageQueueId BIGINT NOT NULL AUTO_INCREMENT ,
  MessageToken VARCHAR(45) NULL COMMENT 'This is a guid.' ,
  UserId INT NULL ,
  UserLocationMACId INT NULL ,
  EquipmentId INT NULL ,
  MACUnpairedId INT NULL ,
  SourceAddress INT NULL DEFAULT 832 ,
  DestinationAddress INT NULL COMMENT 'this will come from equipment table' ,
  MessageStatus INT NULL COMMENT '1 = queue, 2 = accepted, 3 = retry, 4 = success, 5 = fail' ,
  MessageRetry INT NULL DEFAULT 0 ,
  MessageType VARCHAR(45) NULL COMMENT 'eg readObjectDataClassAll, writeObjectDataClass, readObjectSystemID' ,
  MessageRequest VARBINARY(1024) NULL ,
  MessageResponse VARBINARY(1024) NULL ,
  ClientDateTime DATETIME NULL COMMENT 'mobile device will send datetime' ,
  CreateDateTime__Gen DATETIME NULL ,
  UpdateDateTime__Gen DATETIME NULL ,
  PRIMARY KEY (MessageQueueId) ,
  INDEX FK_UserID_1_idx (UserId ASC) ,
  INDEX FK_UserLocationMACID_1_idx (UserLocationMACId ASC) ,
  CONSTRAINT FK_UserID_1
    FOREIGN KEY (UserId )
    REFERENCES econet.user (UserId )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT FK_UserLocationMACId_1
    FOREIGN KEY (UserLocationMACId )
    REFERENCES econet.userlocationmac (UserLocationMACId )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	
	call rheem.AddColumnIfNotExists('econet','messagequeue','ObjName','VARCHAR(45)');

	
	
	call rheem.CreateIndexIfNotExists('econet', 'messagequeue_idx1', 'messagequeue', 'MessageToken', null);
	call rheem.CreateIndexIfNotExists('econet', 'messagequeue_idx2', 'messagequeue', 'MessageType', null);	
	call rheem.CreateIndexIfNotExists('econet', 'messagequeue_idx3', 'messagequeue', 'MessageStatus', null);
	call rheem.CreateIndexIfNotExists('econet', 'messagequeue_idx4', 'messagequeue', 'MACUnpairedId', null);
	call rheem.CreateIndexIfNotExists('econet', 'messagequeue_idx5', 'messagequeue', 'UserLocationMACId', null);
	
	ALTER TABLE `econet`.`messagequeue` 
CHANGE COLUMN `ObjName` `ObjName` VARCHAR(500) NULL DEFAULT NULL ;
