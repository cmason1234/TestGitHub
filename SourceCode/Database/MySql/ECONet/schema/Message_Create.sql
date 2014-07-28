Use econet;

CREATE TABLE IF NOT EXISTS message(
	MessageId INT NOT NULL AUTO_INCREMENT ,
	MessageTypeId INT NOT NULL,
	MessageTitle VARCHAR(50) NOT NULL,
	MessageDescription VARCHAR(50) NOT NULL,
	CreateDateTime__Gen DATETIME not NULL,
	UpdateDateTime__Gen DATETIME not NULL,
    PRIMARY KEY (MessageId),
		CONSTRAINT FK_Message_1 FOREIGN KEY (MessageTypeId) REFERENCES messagetype(MessageTypeId) ON DELETE CASCADE
);

call rheem.CreateIndexIfNotExists('econet', 'Message_idx1', 'message', 'MessageTypeId', null);

