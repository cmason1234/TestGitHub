Use econet;

CREATE TABLE IF NOT EXISTS activemessages(
	MessageQueueId INT Not Null, 
	MessageToken varchar(45),
	IpAddress varchar(45), 
	SocketSessionId varchar(45), 
	MessageStatus INT,
	UpdateDateTime__Gen DATETIME,
	Primary Key (MessageQueueId)
);

call rheem.CreateIndexIfNotExists('econet', 'activemessages_idx1', 'activemessages', 'SocketSessionId', NULL);
call rheem.CreateIndexIfNotExists('econet', 'activemessages_idx2', 'activemessages', 'IpAddress', NULL);
call rheem.CreateIndexIfNotExists('econet', 'activemessages_idx3', 'activemessages', 'MessageToken', NULL);
