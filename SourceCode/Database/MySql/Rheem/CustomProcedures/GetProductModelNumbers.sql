USE rheem;

DROP PROCEDURE IF Exists GetProductModelNumbers;

DELIMITER $$
CREATE PROCEDURE GetProductModelNumbers(
    IN productIDparam varchar(50))
BEGIN

	DECLARE whichSelect varchar(50);
	SELECT CategoryName INTO @catName from ru_productcategory rpc
               INNER JOIN ru_product rp on rpc.ProductCategoryID = rp.ProductCategoryID 
			        AND rp.ProductID = productIDparam;
	
	SELECT BrandName into @brandName FROM rdb_brand rdb 
        inner join ru_product rp on rdb.BrandID=rp.BrandID 
		                   AND rp.ProductID=productIDparam;

	SET whichSelect = (SELECT CASE 
			WHEN @catName = 'Gas Furnaces' THEN 'FURN'
			WHEN @catName = 'Condensing Units' THEN 'Condenser'
			WHEN @catName = 'Heat Pumps' THEN 'Condenser'
			WHEN @catName = 'Package Air Conditioners' THEN 'PackageAC'
			WHEN @catName = 'Package Heat Pumps' THEN 'PackageHP'
			WHEN @catName = 'Dual Fuel' THEN 'DualFuel'
			WHEN @catName = 'Package Gas/Electric' THEN 'PackageGasElect'
			WHEN @catName = 'Split System Condensing  Unit' THEN 'Condenser'
			WHEN @catName = 'Split System Heat Pumps' THEN 'Condenser'
			WHEN @catName = 'Cooling Coils' THEN 'DXCoil'
			WHEN @catName = 'Air Handlers' THEN 'Air_Hand'
	END);

	IF whichSelect = 'Condenser' THEN
		SELECT p.Model, 
			   pm.RPS_Model, 
			   RPS_Voltage, 
			   c.Width,
			   c.Length,
			   c.Height,
			   c.Weight,
			   c.LiquidConn,
			   c.SuctionConn,
			   c.Fuse,
			   c.Sound,
			   c.IDCFM,
			   '' As ElectricHeatRange,
			   0 As AirflowLo,
			   0 As AirflowHi,
			   0 As InputBTUHR,
			   0 As OutputBTUHR,
			   '' As MotorType,
			   0.0 As AFUE,
			   0 As MinCircuitAmpacity,
			   0.0 As FaceArea,
			   '0' As OutWidth,
			   '0' As OutDepth,
			   0.0 As GrossCoolingCapacity,
			   '0.0' AS UHeight,
			   '0.0' AS ULength,
			   '0.0' AS UWidth,
			   'Condenser' AS ModelCategory
		FROM rheem.ru_product p
			INNER JOIN rheem.ru_productmodel pm ON pm.ProductID=p.ProductID 
			INNER JOIN rheem.rps_condenser c ON c.Model=pm.RPS_Model and c.Voltage=pm.RPS_Voltage
		WHERE
			p.ProductID=productIDparam
		ORDER BY pm.RPS_Model, RPS_Voltage;

	ELSEIF whichSelect = 'FURN' THEN
		SELECT p.Model, 
			   pm.RPS_Model, 
			   RPS_Voltage, 
			   f.Width,
			   f.Depth AS Length,
			   f.Height,
			   f.Weight,
			   'N/A' AS LiquidConn,
			   'N/A' AS SuctionConn,
			   0 AS Fuse,
			   0 AS Sound,
			   0 AS IDCFM,
			   '' As ElectricHeatRange,
			   f.AirflowLo,
			   f.AirflowHi,
			   f.Input As InputBTUHR,
			   f.Output As OutputBTUHR,
			   f.MtrType As MotorType,
			   f.AFUE,
			   0 As MinCircuitAmpacity,
			   0.0 As FaceArea,
			   '0' As OutWidth,
			   '0' As OutDepth,
			   0.0 As GrossCoolingCapacity,
			   '0.0' AS UHeight,
			   '0.0' AS ULength,
			   '0.0' AS UWidth,
			   'FURN' AS ModelCategory
		FROM rheem.ru_product p
			INNER JOIN rheem.ru_productmodel pm ON pm.ProductID=p.ProductID
			INNER JOIN rheem.rdb_brand b ON b.BrandID=p.BrandID
			INNER JOIN rheem.rps_furn f ON f.ARIModel=pm.RPS_Model
		WHERE
			f.Manuf = b.BrandName and
			p.ProductID=productIDparam
		ORDER BY p.Model,pm.RPS_Model,RPS_Voltage;
		
	ELSEIF whichSelect = 'DXCoil' THEN
		SELECT p.Model, 
			   pm.RPS_Model, 
			   RPS_Voltage, 
			   d.Width,
			   d.Depth AS Length,
			   d.Height,
			   d.Weight,
			   d.LiquidConn,
			   d.SuctionConn,
			   0 AS Fuse,
			   0 AS Sound,
			   0 AS IDCFM,
			   '' As ElectricHeatRange,
			   0 As AirflowLo,
			   0 As AirflowHi,
			   0 As InputBTUHR,
			   0 As OutputBTUHR,
			   '' As MotorType,
			   0.0 As AFUE,
			   0 As MinCircuitAmpacity,
			   d.FaceArea,
			   d.OutWidth,
			   d.OutDepth,
			   0.0 As GrossCoolingCapacity,
			   UHeight,
			   UDepth as ULength,
			   UWidth,
			   'DXCoil' AS ModelCategory
		FROM rheem.ru_product p
			INNER JOIN rheem.ru_productmodel pm ON pm.ProductID=p.ProductID
			INNER JOIN rheem.rps_dxcoil d ON d.ARIModel=pm.RPS_Model
		WHERE
			p.ProductID=productIDparam
        ORDER BY p.Model,pm.RPS_Model,RPS_Voltage;
		
	ELSEIF whichSelect = 'Air_Hand' THEN
		SELECT p.Model, 
			   pm.RPS_Model, 
			   RPS_Voltage, 
			   a.Width,
			   a.Depth AS Length,
			   a.Height,
			   a.Weight,
			   a.LiquidConn,
			   a.SuctionConn,
			   0 AS Fuse,
			   0 AS Sound,
			   0 AS IDCFM,
			   a.ElecHtr As ElectricHeatRange,
			   a.AirflowLo,
			   a.AirflowHi,
			   0 As InputBTUHR,
			   0 As OutputBTUHR,
			   '' As MotorType,
			   0.0 As AFUE,
			   a.MCA As MinCircuitAmpacity,
			   0.0 As FaceArea,
			   '0' As OutWidth,
			   '0' As OutDepth,
			   0.0 As GrossCoolingCapacity,
   			   '0.0' AS UHeight,
			   '0.0' AS ULength,
			   '0.0' AS UWidth,
			   'Air_Hand' AS ModelCategory
		FROM rheem.ru_product p
			INNER JOIN rheem.ru_productmodel pm ON pm.ProductID=p.ProductID
			INNER JOIN rheem.rps_air_hand a ON a.ARIModel=pm.RPS_Model
		WHERE
			p.ProductID=productIDparam
        ORDER BY p.Model,pm.RPS_Model,RPS_Voltage;

	ELSEIF whichSelect = 'PackageAC' THEN  -- The select for all the rest below here are the same, kept seperate in case they need to change
		SELECT p.Model, 
			   pm.RPS_Model, 
			   RPS_Voltage, 
			   c.Width,
			   c.Length,
			   c.Height,
			   c.Weight,
			   c.LiquidConn,
			   c.SuctionConn,
			   c.Fuse,
			   c.Sound,
			   c.IDCFM,
			   '' As ElectricHeatRange,
			   0 As AirflowLo,
			   0 As AirflowHi,
			   0 As InputBTUHR,
			   0 As OutputBTUHR,
			   '' As MotorType,
			   0.0 As AFUE,
			   0 As MinCircuitAmpacity,
			   0.0 As FaceArea,
			   '0' As OutWidth,
			   '0' As OutDepth,
			   a.Gross As GrossCoolingCapacity,
			   '0.0' AS UHeight,
			   '0.0' AS ULength,
			   '0.0' AS UWidth,
			   'PackageAC' AS ModelCategory 
		FROM rheem.ru_product p
			INNER JOIN rheem.ru_productmodel pm ON pm.ProductID=p.ProductID
			INNER JOIN rps_condenser c ON pm.rps_id = c.ID and 
				pm.rps_model = c.Model and 
				pm.rps_voltage = c.Voltage
			left outer join rps_ari a on 
				SUBSTRING(c.Model, 1, 11)=a.arimodel
		WHERE
			p.ProductID=productIDparam
        ORDER BY p.Model,pm.RPS_Model,RPS_Voltage;
	
	ELSEIF whichSelect = 'PackageHP' THEN
		SELECT p.Model, 
			   pm.RPS_Model, 
			   RPS_Voltage, 
			   c.Width,
			   c.Length,
			   c.Height,
			   c.Weight,
			   c.LiquidConn,
			   c.SuctionConn,
			   c.Fuse,
			   c.Sound,
			   c.IDCFM,
			   '' As ElectricHeatRange,
			   0 As AirflowLo,
			   0 As AirflowHi,
			   0 As InputBTUHR,
			   0 As OutputBTUHR,
			   '' As MotorType,
			   0.0 As AFUE,
			   0 As MinCircuitAmpacity,
			   0.0 As FaceArea,
			   '0' As OutWidth,
			   '0' As OutDepth,
			   a.Gross As GrossCoolingCapacity,
			   '0.0' AS UHeight,
			   '0.0' AS ULength,
			   '0.0' AS UWidth,
			   'PackageAC' AS ModelCategory 
		FROM rheem.ru_product p
			INNER JOIN rheem.ru_productmodel pm ON pm.ProductID=p.ProductID
			INNER JOIN rps_condenser c ON pm.rps_id = c.ID and 
				pm.rps_model = c.Model and 
				pm.rps_voltage = c.Voltage
			left outer join rps_ari a on 
				SUBSTRING(c.Model, 1, 11)=a.arimodel
		WHERE
			p.ProductID=productIDparam
        ORDER BY p.Model,pm.RPS_Model,RPS_Voltage;
	
	ELSEIF whichSelect = 'DualFuel' THEN
		SELECT p.Model, 
				   pm.RPS_Model, 
				   RPS_Voltage, 
				   c.Width,
				   c.Length,
				   c.Height,
				   c.Weight,
				   c.LiquidConn,
				   c.SuctionConn,
				   c.Fuse,
				   c.Sound,
				   c.IDCFM,
				   '' As ElectricHeatRange,
				   0 As AirflowLo,
				   0 As AirflowHi,
				   0 As InputBTUHR,
				   0 As OutputBTUHR,
				   '' As MotorType,
				   0.0 As AFUE,
				   0 As MinCircuitAmpacity,
				   0.0 As FaceArea,
				   '0' As OutWidth,
				   '0' As OutDepth,
				   a.Gross As GrossCoolingCapacity,
				   '0.0' AS UHeight,
				   '0.0' AS ULength,
				   '0.0' AS UWidth,
				   'PackageAC' AS ModelCategory 
			FROM rheem.ru_product p
				INNER JOIN rheem.ru_productmodel pm ON pm.ProductID=p.ProductID
				INNER JOIN rps_condenser c ON pm.rps_id = c.ID and 
					pm.rps_model = c.Model and 
					pm.rps_voltage = c.Voltage
				left outer join rps_ari a on 
					SUBSTRING(c.Model, 1, 11)=a.arimodel
			WHERE
				p.ProductID=productIDparam
			ORDER BY p.Model,pm.RPS_Model,RPS_Voltage;

	ELSEIF whichSelect = 'PackageGasElect' THEN
		SELECT p.Model, 
			   pm.RPS_Model, 
			   RPS_Voltage, 
			   c.Width,
			   c.Length,
			   c.Height,
			   c.Weight,
			   c.LiquidConn,
			   c.SuctionConn,
			   c.Fuse,
			   c.Sound,
			   c.IDCFM,
			   '' As ElectricHeatRange,
			   0 As AirflowLo,
			   0 As AirflowHi,
			   0 As InputBTUHR,
			   0 As OutputBTUHR,
			   '' As MotorType,
			   0.0 As AFUE,
			   0 As MinCircuitAmpacity,
			   0.0 As FaceArea,
			   '0' As OutWidth,
			   '0' As OutDepth,
			   a.Gross As GrossCoolingCapacity,
			   '0.0' AS UHeight,
			   '0.0' AS ULength,
			   '0.0' AS UWidth,
			   'PackageAC' AS ModelCategory 
		FROM rheem.ru_product p
			INNER JOIN rheem.ru_productmodel pm ON pm.ProductID=p.ProductID
			INNER JOIN rps_condenser c ON pm.rps_id = c.ID and 
				pm.rps_model = c.Model and 
				pm.rps_voltage = c.Voltage
			left outer join rps_ari a on 
				SUBSTRING(c.Model, 1, 11)=a.arimodel
		WHERE
			p.ProductID=productIDparam
		ORDER BY p.Model,pm.RPS_Model,RPS_Voltage;
			
	ELSE
		SELECT 'NOT FOUND' AS Model, 
			   'NOT FOUND' AS RPS_Model, 
			   '0' AS RPS_Voltage, 
			   '0' AS Width,
			   '0' AS Length,
			   '0' AS Height,
			   '0' AS Weight,
			   '0' AS LiquidConn,
			   '0' AS SuctionConn,
			   0 AS Fuse,
			   0 AS Sound,
			   0 AS IDCFM,
			   '' As ElectricHeatRange,
			   0 As AirflowLo,
			   0 As AirflowHi,
			   0 As InputBTUHR,
			   0 As OutputBTUHR,
			   '' As MotorType,
			   0.0 As AFUE,
			   0 As MinCircuitAmpacity,
			   0.0 As FaceArea,
			   '0' As OutWidth,
			   '0' As OutDepth,
			   0.0 As GrossCoolingCapacity,
			   '0.0' AS UHeight,
			   '0.0' AS ULength,
			   '0.0' AS UWidth,
			   'UNKNOWN' AS ModelCategory;
	END IF;




END$$
DELIMITER ;
