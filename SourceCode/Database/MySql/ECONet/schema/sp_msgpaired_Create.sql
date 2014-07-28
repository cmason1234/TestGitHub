Use econet;

CREATE TABLE IF NOT EXISTS sp_msgpaired(
	MessageQueueId INT, 
	MessageToken varchar(45), 
	MessageStatus INT, 
	MessageType varchar(45), 
	ClientDateTime datetime, 
	IpAddress varchar(45), 
	PortNumberListen INT, 
	SocketSessionId varchar(45), 
	EquipmentId INT
);

call rheem.CreateIndexIfNotExists('econet', 'msgpaired_idx1', 'sp_msgpaired', 'SocketSessionId', NULL);
call rheem.CreateIndexIfNotExists('econet', 'msgpaired_idx2', 'sp_msgpaired', 'MessageType', NULL);
call rheem.CreateIndexIfNotExists('econet', 'msgpaired_idx3', 'sp_msgpaired', 'IpAddress', NULL);