Use rheem;

CREATE TABLE IF NOT EXISTS impunit(
  impunitid int(11) NOT NULL AUTO_INCREMENT,
  httpagent varchar(45) DEFAULT NULL,
  mode int(11) DEFAULT NULL,
  setpoint float DEFAULT NULL,
  status int(11) DEFAULT NULL,
  uppertemp float DEFAULT NULL,
  source varchar(45) DEFAULT NULL,
  dtstamp datetime DEFAULT NULL,
   PRIMARY KEY (ImpUnitID)
);

CREATE TABLE IF NOT EXISTS impowner(
	impownerid int(11) NOT NULL AUTO_INCREMENT,
	firstname varchar(45) DEFAULT NULL,
	lastname varchar(45) DEFAULT NULL,
	email varchar(145) DEFAULT NULL,
	dtstamp datetime DEFAULT NULL,
   PRIMARY KEY (impownerid)
);

CREATE TABLE IF NOT EXISTS impownerunit(
	impownerunitid int(11) NOT NULL AUTO_INCREMENT,
	impownerid int(11) DEFAULT NULL,
	impunitid int(11) DEFAULT NULL,
   PRIMARY KEY (impownerunitid),
CONSTRAINT FK_ImpOwnerUnit_ImpOwnerID FOREIGN KEY (impownerid)
REFERENCES impowner (impownerid) ON DELETE CASCADE,
CONSTRAINT FK_ImpUnit_ImpOwnerID FOREIGN KEY (impunitid)
REFERENCES impunit (impunitid) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS impunithistory (
  impunithistoryid INT NOT NULL AUTO_INCREMENT ,
  impunitid INT NULL ,
  httpagent VARCHAR(45) NULL ,
  mode INT NULL ,
  setpoint FLOAT NULL ,
  status INT NULL ,
  uppertemp FLOAT NULL ,
  source VARCHAR(45) NULL ,
  dtstamp DATETIME DEFAULT NULL,
  PRIMARY KEY (impunithistoryid) );
  