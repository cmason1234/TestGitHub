Use econet;

CREATE TABLE IF NOT EXISTS usermessage(
	UserMessageId INT NOT NULL AUTO_INCREMENT ,
	UserId INT NOT NULL,
	MessageId INT NOT NULL,
	OptInDate datetime NOT NULL,
	CreateDateTime__Gen DATETIME not NULL,
	UpdateDateTime__Gen DATETIME not NULL,
    PRIMARY KEY (UserMessageId),
		CONSTRAINT FK_UserMessage_1 FOREIGN KEY (MessageId) REFERENCES message(MessageId) ON DELETE CASCADE,
		CONSTRAINT FK_UserMessage_2 FOREIGN KEY (UserId) REFERENCES user(UserId) ON DELETE CASCADE
);

call rheem.CreateIndexIfNotExists('econet', 'UserMessage_idx1', 'usermessage', 'UserId', null);
ALTER TABLE usermessage MODIFY OptInDate datetime NULL;

