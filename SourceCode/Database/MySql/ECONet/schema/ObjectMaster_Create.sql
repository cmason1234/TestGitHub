Use econet;

CREATE TABLE IF NOT EXISTS objectmaster (
  ObjectMasterId INT NOT NULL AUTO_INCREMENT ,
  EquipmentMasterId INT NULL ,
  ObjName VARCHAR(45) NULL ,
  OnBoot BIT NULL DEFAULT 0 ,
  OnBootOrder INT NULL ,
  Poll BIT NULL DEFAULT 0 ,
  PollFrequency INT NULL COMMENT 'This is the poll frequency in minutes' ,
  CreateDateTime__Gen datetime NOT NULL,
  UpdateDateTime__Gen datetime NOT NULL,
  PRIMARY KEY (ObjectMasterId) );
  
  call rheem.CreateIndexIfNotExists('econet', 'ObjectMaster_idx1', 'objectmaster', 'EquipmentMasterId', null);