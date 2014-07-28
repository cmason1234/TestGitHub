Use econet;

INSERT IGNORE INTO server SET ServerId = 1, IPAddress = '174.129.124.230', PortNumberListen = 8089, CurrentConnections = 0, UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();

/*
Equipment Categories are : AC, WH, POOL, OTHER
*/
INSERT IGNORE INTO equipmentcategory SET EquipmentCategoryId = 1, CategoryName = 'AC', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentcategory SET EquipmentCategoryId = 2, CategoryName = 'WH', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentcategory SET EquipmentCategoryId = 3, CategoryName = 'POOL', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentcategory SET EquipmentCategoryId = 4, CategoryName = 'OTHER', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();


/*
Equipment Master
*/
INSERT IGNORE INTO equipmentmaster SET EquipmentMasterId = 1, EquipmentCategoryId = 4, LowerLimit = 64, UpperLimit=127, DisplayInMobile = 0, EquipmentDesc = 'Bootloaders', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentmaster SET EquipmentMasterId = 2, EquipmentCategoryId = 4, LowerLimit = 128, UpperLimit=143, DisplayInMobile = 0, EquipmentDesc = 'Thermocouple Boards', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentmaster SET EquipmentMasterId = 3, EquipmentCategoryId = 2, LowerLimit = 256, UpperLimit=319, DisplayInMobile = 0, EquipmentDesc = 'Water Heater Display', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentmaster SET EquipmentMasterId = 4, EquipmentCategoryId = 2, LowerLimit = 320, UpperLimit=383, DisplayInMobile = 1, EquipmentDesc = 'Heat Pump Water Heater Control', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentmaster SET EquipmentMasterId = 5, EquipmentCategoryId = 2, LowerLimit = 384, UpperLimit=447, DisplayInMobile = 0, EquipmentDesc = 'RHE Valve Control', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentmaster SET EquipmentMasterId = 6, EquipmentCategoryId = 1, LowerLimit = 448, UpperLimit=511, DisplayInMobile = 0, EquipmentDesc = 'Honeywell Modulating Furnace', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentmaster SET EquipmentMasterId = 7, EquipmentCategoryId = 1, LowerLimit = 512, UpperLimit=575, DisplayInMobile = 1, EquipmentDesc = 'Rheem Interface Display', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentmaster SET EquipmentMasterId = 8, EquipmentCategoryId = 1, LowerLimit = 576, UpperLimit=639, DisplayInMobile = 0, EquipmentDesc = 'Climate-Talk to Rheem-NET ODU Translator', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentmaster SET EquipmentMasterId = 9, EquipmentCategoryId = 3, LowerLimit = 640, UpperLimit=703, DisplayInMobile = 0, EquipmentDesc = 'UTEC Pool Heater Control', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentmaster SET EquipmentMasterId = 10, EquipmentCategoryId = 2, LowerLimit = 704, UpperLimit=767, DisplayInMobile = 1, EquipmentDesc = 'Electric Water Heater Control', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentmaster SET EquipmentMasterId = 11, EquipmentCategoryId = 1, LowerLimit = 768, UpperLimit=831, DisplayInMobile = 0, EquipmentDesc = 'RHE Valve Communicator', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO equipmentmaster SET EquipmentMasterId = 12, EquipmentCategoryId = 2, LowerLimit = 832, UpperLimit=896, DisplayInMobile = 0, EquipmentDesc = 'NET Tran?', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();


INSERT IGNORE INTO messagetype SET MessageTypeId = 1, MessageTypeName = 'Email', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO messagetype SET MessageTypeId = 2, MessageTypeName = 'Text', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();

INSERT IGNORE INTO message SET MessageId = 1, MessageTypeId = 1, MessageTitle = 'Email Alert', MessageDescription = '', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO message SET MessageId = 2, MessageTypeId = 2, MessageTitle = 'Text Alert', MessageDescription = '', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();
INSERT IGNORE INTO message SET MessageId = 3, MessageTypeId = 1, MessageTitle = 'Marketing Message', MessageDescription = '', UpdateDateTime__Gen = NOW(), CreateDateTime__Gen = NOW();


INSERT IGNORE INTO alertdetail SET  AlertDetailId = 1, AlertType = 'Alert', AlertCode = 'A100', UserMessage = 'Lower Heater Temp Thermistor Failure', CustomMessage = '', CallToAction = 'Please call a contractor or technical support.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();
INSERT IGNORE INTO alertdetail SET  AlertDetailId = 2, AlertType = 'Alert', AlertCode = 'A101', UserMessage = 'Upper Heater Temp Thermistor Failure', CustomMessage = '', CallToAction = 'Please call a contractor or technical support.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();
INSERT IGNORE INTO alertdetail SET  AlertDetailId = 3, AlertType = 'Alert', AlertCode = 'A104', UserMessage = 'Emergency Cut Off (ECO) Alarm', CustomMessage = '', CallToAction = 'Please call a contractor or technical support.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();
INSERT IGNORE INTO alertdetail SET  AlertDetailId = 4, AlertType = 'Alert', AlertCode = 'A105', UserMessage = 'Lower Element Error', CustomMessage = '', CallToAction = 'Please call a contractor or technical support.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();
INSERT IGNORE INTO alertdetail SET  AlertDetailId = 5, AlertType = 'Alert', AlertCode = 'A106', UserMessage = 'Upper Element Error', CustomMessage = '', CallToAction = 'Please call a contractor or technical support.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();
INSERT IGNORE INTO alertdetail SET  AlertDetailId = 6, AlertType = 'Alert', AlertCode = 'A107', UserMessage = 'Element Wire Routing Error', CustomMessage = '', CallToAction = 'Please call a contractor or technical support.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();
INSERT IGNORE INTO alertdetail SET  AlertDetailId = 7, AlertType = 'Alert', AlertCode = 'A108', UserMessage = 'Lower Element Relay Stuck On Error', CustomMessage = '', CallToAction = 'Please call a contractor or technical support.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();
INSERT IGNORE INTO alertdetail SET  AlertDetailId = 8, AlertType = 'Alert', AlertCode = 'A109', UserMessage = 'Upper Element Relay Stuck On Error', CustomMessage = '', CallToAction = 'Please call a contractor or technical support.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();
INSERT IGNORE INTO alertdetail SET  AlertDetailId = 9, AlertType = 'Alert', AlertCode = 'A500', UserMessage = 'Configuration Data Restore Failure', CustomMessage = '', CallToAction = 'Please call a contractor or technical support.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();

INSERT IGNORE INTO alertdetail SET  AlertDetailId = 10, AlertType = 'Critical', AlertCode = 'A102', UserMessage = 'Water Sensor Alarm', CustomMessage = '', CallToAction = 'Detach the water sensor cable form the water heater and see if that resets the alarm. If so, they need to dry out the sensor cable.<br /><br />If the unit is still alarming, contact tech support. The most likely solution would be a replacement controller. This alarm cannot be manually reset.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();
INSERT IGNORE INTO alertdetail SET  AlertDetailId = 11, AlertType = 'Critical', AlertCode = 'A103', UserMessage = 'Fill Tank with Water [Dry Fire]', CustomMessage = '', CallToAction = 'Fill water heater with water then cycle power.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();

INSERT IGNORE INTO alertdetail SET  AlertDetailId = 12, AlertType = 'Message', AlertCode = 'I100', UserMessage = 'Communication with IMP/API/Internet Failure', CustomMessage = '', CallToAction = 'App cannot connect to water heater, please check WIFI settings.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();
INSERT IGNORE INTO alertdetail SET  AlertDetailId = 13, AlertType = 'Message', AlertCode = 'I101', UserMessage = 'Software Update', CustomMessage = '', CallToAction = 'There is a software update, please go into settings to update to the latest version.', CreateDateTime__Gen = NOW(), UpdateDateTime__Gen = NOW();
