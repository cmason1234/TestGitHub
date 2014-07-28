Use econet;

DROP TRIGGER if exists updatesocketsessionid_unpaired;

/*DELIMITER $$

CREATE TRIGGER updatesocketsessionid_unpaired AFTER UPDATE ON macunpaired
FOR EACH ROW BEGIN 

	DELETE FROM sp_msgunpaired
	WHERE equipmentId in (SELECT equipmentId FROM equipment WHERE MacUnpairedId = OLD.MacUnpairedId );
	
	IF NEW.SocketSessionId = 0 THEN
		UPDATE equipment
		SET IsConnected = 0
		WHERE MacUnpairedId = OLD.MacUnpairedId; 
	ELSE
		UPDATE equipment
		SET IsConnected = 1
		WHERE MacUnpairedId = OLD.MacUnpairedId; 
	END IF;
	
	UPDATE sp_msgunpaired
	SET SocketSessionId = NEW.SocketSessionId
	WHERE SocketSessionId = OLD.SocketSessionId;

	
END $$

DELIMITER ;
*/
