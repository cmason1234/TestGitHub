Use econet;

Drop table IF exists sp_msgunpaired;

/* This table is probably not used any longer and the file can be deleted at some future time
CREATE TABLE IF NOT EXISTS sp_msgunpaired(
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

call rheem.CreateIndexIfNotExists('econet', 'msgunpaired_idx1', 'sp_msgunpaired', 'SocketSessionId', NULL);
call rheem.CreateIndexIfNotExists('econet', 'msgunpaired_idx2', 'sp_msgunpaired', 'MessageType', NULL);
*/
