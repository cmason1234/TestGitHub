Use rheem;

CREATE TABLE IF NOT EXISTS rps_ari(
    ariId int(11) NOT NULL AUTO_INCREMENT,
	ID int NOT NULL,
	ARIRef int NOT NULL,
	RRef int NULL,
	Status smallint NULL,
	Manufacturer nvarchar(50) NULL,
	Brand nvarchar(50) NULL,
	Type nvarchar(20) NULL,
	ARIModel nvarchar(25) NULL,
	Model nvarchar(50) NULL,
	AH nvarchar(50) NULL,
	Coil nvarchar(25) NULL,
	Furnace nvarchar(50) NULL,
	Capacity real NULL,
	Latent real NULL,
	EER real NULL,
	Efficiency real NULL,
	Cap47 real NULL,
	COP47 real NULL,
	Cap17 real NULL,
	COP17 real NULL,
	HSPF real NULL,
	Gross real NULL,
	PRIMARY KEY (ariId)
);

