Use econet;

DROP TRIGGER if exists updateequipmentforserver;

DELIMITER $$

CREATE TRIGGER updateequipmentforserver AFTER UPDATE ON server
FOR EACH ROW BEGIN 

	IF NEW.CurrentConnections = 0 THEN
		UPDATE equipment
		SET IsConnected = 0
		WHERE UserLocationMacId in (SELECT UserLocationMacId from userlocationmac WHERE ServerId = OLD.ServerId); 
		
		UPDATE equipment
		SET IsConnected = 0
		WHERE UserLocationMacId in (SELECT MacUnpairedId from macunpaired WHERE ServerId = OLD.ServerId); 
	END IF;
	
END $$

DELIMITER ;
