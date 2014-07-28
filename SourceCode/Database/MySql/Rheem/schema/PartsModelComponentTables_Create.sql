Use rheem;

CREATE TABLE IF NOT EXISTS ru_parts_model(
	Parts_ModelID int NOT NULL,
	Model varchar(50) NOT NULL,
	ModelDescription varchar(100) NOT NULL,
	Brand varchar(50) NOT NULL,
	PRIMARY KEY (Parts_ModelID)
);
call CreateIndexIfNotExists(NULL, 'partsmodel_idx1', 'ru_parts_model', 'Model', NULL);

CREATE TABLE IF NOT EXISTS ru_parts_component(
		Parts_ComponentID int NOT NULL,
		ComponentNumber varchar(50) NOT NULL,
		UPCNumber varchar(50) NOT NULL,
		ComponentDescription varchar(300) NOT NULL,
		ComponentLength float,
		ComponentWidth float,
		ComponentHeight float,
		ComponentWeight float,
		Replacement varchar(50),
		PRIMARY KEY (Parts_ComponentID)
);
call CreateIndexIfNotExists(NULL, 'partscomponent_idx1', 'ru_parts_component', 'ComponentNumber', NULL);

CREATE TABLE IF NOT EXISTS ru_parts_modelcomponent(
		Parts_ModelComponentID int NOT NULL,
		Parts_ModelID int NOT NULL,
		Parts_ComponentID int NOT NULL,
		Usage_Count float NOT NULL,
		PRIMARY KEY (Parts_ModelComponentID),
		CONSTRAINT FK_ModelComponent_1 FOREIGN KEY (Parts_ModelID)
		  REFERENCES ru_parts_model(Parts_ModelID) ON DELETE CASCADE,
		CONSTRAINT FK_ModelComponent_2 FOREIGN KEY (Parts_ComponentID) 
		  REFERENCES ru_parts_component(Parts_ComponentID) ON DELETE CASCADE
);

