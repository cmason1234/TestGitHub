Use rheem;

CREATE TABLE IF NOT EXISTS admaker_ad (
  admaker_AdID int(11) NOT NULL AUTO_INCREMENT,
  PersonID varchar(64) NOT NULL,
  PageSize varchar(250) NOT NULL,
  AdName varchar(64) DEFAULT NULL,
  FileName varchar(1024) NOT NULL,
  HeaderText varchar(250) NOT NULL,
  LegalCopy varchar(250) NOT NULL,
  SavingsCopy varchar(250) NOT NULL,
  BrandName varchar(30) NOT NULL,
  PhoneNumberText varchar(250) DEFAULT NULL,
  WebSiteText varchar(250) DEFAULT NULL,
  Color bit(1) NOT NULL DEFAULT b'0',
  PendingReview bit(1) NOT NULL DEFAULT b'0',
  LogoImageURL varchar(250) DEFAULT NULL,
  HeadLineImageURL varchar(250) DEFAULT NULL,
  ProductImageURL varchar(250) DEFAULT NULL,
  PromoImage1URL varchar(250) DEFAULT NULL,
  PromoImage2URL varchar(250) DEFAULT NULL,
  BulletCopyText1 varchar(250) DEFAULT NULL,
  BulletCopyText2 varchar(250) DEFAULT NULL,
  BulletCopyText3 varchar(250) DEFAULT NULL,
  BulletCopyText4 varchar(250) DEFAULT NULL,
  CreateDateTime__Gen datetime DEFAULT NULL,
  UpdateDateTime__Gen datetime DEFAULT NULL,
  PRIMARY KEY (admaker_AdID)
);

Call ChangeColumnIfExists(null, 'admaker_ad', 'Color', 'PageStyle', 'VARCHAR(200)');
