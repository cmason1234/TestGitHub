Use rheem;

CREATE TABLE IF NOT EXISTS apilog (
  apilogid INT NOT NULL AUTO_INCREMENT ,
  apikey VARCHAR(50) NULL ,
  responsetime INT NULL ,
  responsesize INT NULL ,
  responsebody TEXT NULL ,
  requestpath VARCHAR(1500) NULL ,
  requestquery VARCHAR(1500) NULL ,
  ipaddress VARCHAR(50) NULL ,
  CreateDateTime__Gen datetime NULL,
  PRIMARY KEY (apilogid) );
  
call CreateIndexIfNotExists(NULL, 'apilog_idx1', 'apilog', 'CreateDateTime__Gen', NULL);
call CreateIndexIfNotExists(NULL, 'apilog_idx2', 'apilog', 'apikey', NULL);

