USE rheem;

DROP PROCEDURE IF Exists GetProductCertifications;
DROP PROCEDURE IF Exists GetProductBadges;

DELIMITER $$
CREATE PROCEDURE GetProductBadges(
    IN productIDparam varchar(50))
BEGIN
	SELECT c.DisplayName as BadgeName,
           c.ExternalURL,
	       c.Description,
           CONCAT('https://s3.amazonaws.com/AWSProd/CertificationLogos/', cd.CloudFileName) AS ImageURL,
		   cg.GroupName as BadgeGroup
	FROM rheem.ru_product p
        INNER JOIN rheem.ru_productcertification pc ON pc.ProductID = p.ProductID
		INNER JOIN rheem.ru_certification c ON c.CertificationID = pc.CertificationID
		INNER JOIN rheem.ru_certificationgroup cg on c.CertificationGroupID=cg.CertificationGroupID
		LEFT OUTER JOIN rheem.ru_clouddocument cd ON cd.ObjectID = pc.CertificationID and cd.CloudBucket = 'CertificationLogos' and cd.CloudFileName like '%gen_100_100.png'
	WHERE p.ProductID = productIDparam;
END$$
DELIMITER ;
