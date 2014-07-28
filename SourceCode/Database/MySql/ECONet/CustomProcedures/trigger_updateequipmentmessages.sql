Use econet;

DROP TRIGGER if exists updateequipmentmessages;

DELIMITER $$

/*CREATE TRIGGER updateequipmentmessages AFTER UPDATE ON equipment
FOR EACH ROW BEGIN 

	IF NEW.IsConnected = '0' THEN
		DELETE FROM sp_msgpaired
		WHERE equipmentId = OLD.EquipmentId ;
		
		DELETE FROM sp_msgunpaired
		WHERE equipmentId = OLD.EquipmentId ;
	END IF;

END $$

DELIMITER ;
