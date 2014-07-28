USE econet;
DROP procedure IF EXISTS GetMessagesToProcessFromQueuePaired;

DELIMITER $$

CREATE PROCEDURE GetMessagesToProcessFromQueuePaired(
	IN p_IpAddress varchar(45),
	IN p_DoUnPaired Bit)
BEGIN
	
	-- Make sure there are no existing rows in the msgstoprocessqueue table for this ipAddress
	delete from msgstoprocessqueue where IpAddress = p_IpAddress;

    drop TEMPORARY table if exists TempMsgQueue;

	create TEMPORARY table IF NOT EXISTS TempMsgQueue (
	    TempMsgQueueId BIGINT NOT NULL AUTO_INCREMENT, 
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
		UpdateDateTime__Gen DATETIME,
		PRIMARY KEY (TempMsgQueueId)
	);

	-- Get messages from activemessages where messagestatus = 2 and time > 10 seconds for this ip_address.
	--  Change status in messagequeue to 3 for these message ids and delete from activemessages
    drop TEMPORARY table if exists tmpmsgtimetbl;

	create TEMPORARY table IF NOT EXISTS tmpmsgtimetbl (
		MessageQueueId BIGINT ,
		maxAge int
		);
	insert into tmpmsgtimetbl (MessageQueueId, maxAge) 
	  select SQL_NO_CACHE MessageQueueId, TIME_TO_SEC(TIMEDIFF(now(),UpdateDateTime__Gen)) 
	      from activemessages where messagestatus in (2,3) and ipaddress=p_IpAddress;
		  
	delete from tmpmsgtimetbl where maxAge < 3;
	delete from activemessages where MessageQueueId in (select MessageQueueId from tmpmsgtimetbl);
	delete from activemessages where SocketSessionId = '0';
	
	update messagequeue set messagestatus=3, UpdateDateTime__Gen=now() 
	where MessageQueueId in (select MessageQueueId from tmpmsgtimetbl);
	
	INSERT INTO TempMsgQueue (MessageQueueId, MessageToken, MessageStatus, MessageType, ClientDateTime, IpAddress, SocketSessionId, EquipmentId, MessageRequest, MessageRetry, messagetypeStatus, UpdateDateTime__Gen )
        	select SQL_NO_CACHE MessageQueueId, MessageToken, MessageStatus, MessageType, ClientDateTime, 
				  s.IpAddress, ulm.SocketSessionId, mq.EquipmentId, 
				  mq.MessageRequest, mq.MessageRetry,
				 case 	MessageType 
					when 'readObjectSystemIDHB' then 1
					when 'readObjectDataClassAllByNumFirst' then 2 
					when 'writeObjectDataClassByStr' then 3 
					when 'readObjectDataClassAllByStr' then 4 END as messagetypeStatus,
				mq.UpdateDateTime__Gen
	 from server s 
	   INNER JOIN userlocationmac ulm ON s.ServerId=ulm.ServerId and
				ulm.RemoteEndPoint <> '0'
				AND (0=(select count(*) from activemessages where ulm.SocketSessionId=SocketSessionId LIMIT 1))
	   INNER JOIN equipment e ON ulm.UserLocationMACID=e.UserLocationMACId and e.IsConnected = '1'
	   INNER JOIN messagequeue mq ON ulm.UserLocationMacId=mq.UserLocationMacId AND e.equipmentid=mq.equipmentId
					 and mq.messagestatus in (1, 3, 4) 
		 where s.IpAddress = p_IpAddress
		   order by SocketSessionId, messagetypeStatus, ClientDateTime ;
		   
	If p_DoUnPaired Then
		INSERT INTO TempMsgQueue (MessageQueueId, MessageToken, MessageStatus, MessageType, ClientDateTime, IpAddress,
			SocketSessionId, EquipmentId, MessageRequest, MessageRetry, messagetypeStatus, UpdateDateTime__Gen)
				select SQL_NO_CACHE MessageQueueId, MessageToken, MessageStatus, MessageType, ClientDateTime, 
					  s.IpAddress, mu.SocketSessionId, mq.EquipmentId, 
					  mq.MessageRequest, mq.MessageRetry,
					 case 	MessageType 
						when 'readObjectSystemIDHB' then 1
						when 'readObjectDataClassAllByNumFirst' then 2 
						when 'writeObjectDataClassByStr' then 3 
						when 'readObjectDataClassAllByStr' then 4 END as messagetypeStatus,
					mq.UpdateDateTime__Gen
		 from server s 
		   INNER JOIN macunpaired mu ON s.ServerId=mu.ServerId and mu.RemoteEndPoint <> '0'
		                AND (0=(select count(*) from activemessages where mu.SocketSessionId=SocketSessionId LIMIT 1))
		   INNER JOIN equipment e ON   mu.MACUnpairedID=e.MACUnpairedID AND e.IsConnected = '1'
		   INNER JOIN messagequeue mq ON e.equipmentid=mq.equipmentId and mu.MACUnpairedId=mq.MACUnpairedId 
		                    and mq.messagestatus in (1, 3, 4) 
			where s.IpAddress = p_IpAddress;
    END IF;	

	
    drop TEMPORARY table if exists TempMsgQueueMins;

	create TEMPORARY table IF NOT EXISTS TempMsgQueueMins (
		SocketSessionId varchar(50),
		TempMsgQueueId BIGINT
    );
	Insert Into TempMsgQueueMins (SocketSessionId, TempMsgQueueId)
	    SELECT SQL_NO_CACHE SocketSessionId, min(TempMsgQueueId) from TempMsgQueue
		    group by SocketSessionId;
			
	DELETE FROM TempMsgQueue Where SocketSessionId = '0';
	
    INSERT INTO msgstoprocessqueue(	MessageQueueId, MessageToken, MessageStatus, MessageType, ClientDateTime, 
    	SocketSessionId, EquipmentId, MessageRequest, MessageRetry, UpdateDateTime__Gen, MessageAge, IpAddress)
		SELECT SQL_NO_CACHE MessageQueueId, MessageToken, MessageStatus, MessageType, ClientDateTime, 
			SocketSessionId, EquipmentId, MessageRequest, MessageRetry, UpdateDateTime__Gen,
			 TIME_TO_SEC(TIMEDIFF(now(),UpdateDateTime__Gen)) as MessageAge, IpAddress
		FROM TempMsgQueue Where TempMsgQueueId in (Select TempMsgQueueId from TempMsgQueueMins);

		
END$$
DELIMITER ;

