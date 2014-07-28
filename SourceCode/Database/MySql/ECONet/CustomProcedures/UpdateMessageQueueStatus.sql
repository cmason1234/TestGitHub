USE econet;
DROP procedure IF EXISTS UpdateMessageQueueStatus;

DELIMITER $$
CREATE PROCEDURE UpdateMessageQueueStatus (
	IN p_MessageToken varchar(45),
	p_MessageStatus Int,
	p_MessageRetry Int,
	p_SocketSessionID varchar(45),
	p_IpAddress varchar(45),
	p_UpdateDateTime__Gen datetime)
BEGIN

	DECLARE d_EquipmentId INT;

	UPDATE messagequeue
	SET MessageStatus = p_MessageStatus,
	MessageRetry = p_MessageRetry,
	UpdateDateTime__Gen = p_UpdateDateTime__Gen
	WHERE MessageToken = p_MessageToken;

	
	If p_MessageStatus > 3 Then

		/* if message is successful, update connection */
		SELECT SQL_NO_CACHE EquipmentId INTO d_EquipmentId
		FROM messagequeue
		WHERE MessageToken = p_MessageToken
		AND EquipmentId IS NOT NULL;
		
		If p_MessageStatus = 4 Then
			Update equipment set IsConnected = 1, UpdateDateTime__Gen = p_UpdateDateTime__Gen  Where EquipmentId = d_EquipmentId;
		End if;

		If p_MessageStatus = 5 Then
			Update equipment set IsConnected = 0, UpdateDateTime__Gen = p_UpdateDateTime__Gen Where EquipmentId = d_EquipmentId;
		End if;

		DELETE FROM messagequeue WHERE MessageToken = p_MessageToken;
		DELETE FROM activemessages WHERE MessageToken = p_MessageToken;
	else 
	
		DELETE FROM activemessages WHERE MessageToken = p_MessageToken;
		
		If p_SocketSessionID = "0" Then
			DELETE FROM msgstoprocessqueue WHERE MessageToken = p_MessageToken;
		Else
			-- insert row in activemessages
			INSERT INTO activemessages (MessageQueueId, MessageToken, 
					UpdateDateTime__GEN, IpAddress, SocketSessionId, MessageStatus)
			  SELECT SQL_NO_CACHE MessageQueueID, MessageToken, UpdateDateTime__GEN, p_IpAddress, p_SocketSessionID, p_MessageStatus
				FROM messagequeue WHERE MessageToken = p_MessageToken;
			
		End If;
		
	End If;
	
END$$

DELIMITER ;
