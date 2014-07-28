USE rheem;

DROP PROCEDURE IF Exists GetProductCategories;

DELIMITER $$
CREATE PROCEDURE GetProductCategories(
    IN productcategoryIDparam varchar(50))
BEGIN

    SELECT ProductcategoryID,
           CategoryName,
           Model,
           Market,
           Brand,
           Series,
           Description,
           GasEfficiency,
           HSPF,
           ComfortControl,
           ComfortControl2,
           Gamma,
           SEER,
           Tonnages,
           CabinetSize,
           ARI210240,
           UL,
           R410A,
           EnergyGuide,
           EnergyStar,
           EnergyMiser,
           CSA,
           SACC,
           EIL,
           NSF,
           HLW,
           SCAQMD,
           ProductCopy,
           VirtualTourText,
           WarrantyText,
           TankWarranty,
           PartsWarranty,
           LaborWarranty,
           HeatExchangeWarranty,
           compressorWarranty,
           ExtendedWarranty,
           DisplayOnBHPG,
           DRHorton,
           GallonCapacity,
           TaxCredit,
           TaxCreditText,
           Gas,
           Electric,
           Tankless,
           Solar,
           SortOrder,
           ProductSystem,
           Common,
           AgencyApprovals,
           EfficiencyRange,
           ContractorFAB,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem.ru_productcategory
    WHERE (LENGTH(productcategoryIDparam) = 0 OR ProductcategoryID = productcategoryIDparam);

END$$
DELIMITER ;
