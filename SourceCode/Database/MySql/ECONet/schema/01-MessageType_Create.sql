Use econet;

CREATE TABLE IF NOT EXISTS messagetype(
	MessageTypeId INT NOT NULL AUTO_INCREMENT ,
	MessageTypeName varchar(50) NOT NULL,
    PRIMARY KEY (MessageTypeId)
);
	call rheem.AddColumnIfNotExists('econet', 'messagetype', 'UpdateDateTime__Gen',  'datetime NOT NULL');
	call rheem.AddColumnIfNotExists('econet', 'messagetype', 'CreateDateTime__Gen',  'datetime NOT NULL');

call rheem.CreateIndexIfNotExists('econet', 'MessageType_idx1', 'messagetype', 'MessageTypeName', null);

