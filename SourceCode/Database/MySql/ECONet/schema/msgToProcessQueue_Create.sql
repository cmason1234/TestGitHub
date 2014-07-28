use econet;

	create table IF NOT EXISTS msgstoprocessqueue (
		MessageQueueId BIGINT ,
		MessageToken VARCHAR(45),
		EquipmentId INT ,
		MACUnpairedId INT,
		MessageStatus INT,
		MessageRetry INT ,
		MessageType VARCHAR(45),
		MessageRequest VARBINARY(1024),
		ClientDateTime DATETIME,
		IpAddress VARCHAR(50), 
		SocketSessionId varchar(50),
		messagetypeStatus INT,
		MessageAge INT,
		UpdateDateTime__Gen DATETIME,
		PRIMARY KEY (MessageQueueId),
		INDEX msgstoprocessqueue_idx1 (IpAddress)
	);
	
	