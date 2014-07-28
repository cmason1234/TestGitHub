Use econet;

DROP TRIGGER if exists updatesocketsessionid_paired;

/*DELIMITER $$

CREATE TRIGGER updatesocketsessionid_paired AFTER UPDATE ON userlocationmac
FOR EACH ROW BEGIN 

	
	IF NEW.SocketSessionId = 0 THEN
		UPDATE equipment
		SET IsConnected = 0
		WHERE UserLocationMacId = OLD.UserLocationMacId; 
	ELSE
		UPDATE equipment
		SET IsConnected = 1
		WHERE UserLocationMacId = OLD.UserLocationMacId; 
	END IF;
	


	
END $$

DELIMITER ;*/
