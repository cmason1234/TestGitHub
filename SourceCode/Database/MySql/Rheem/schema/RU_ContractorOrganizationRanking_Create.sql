Use rheem;

CREATE TABLE IF NOT EXISTS ru_contractororganizationranking(
	ContractorOrganizationRankingID varchar(64) NOT NULL,
	ContractorWaterHeaterID varchar(64) NOT NULL,
	RatingCriteriaID varchar(64) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ContractorOrganizationRankingID)
);

call CreateIndexIfNotExists(null, 'contractororgrank_idx1', 'ru_contractororganizationranking', 'ContractorWaterHeaterID', null);
call CreateIndexIfNotExists(null, 'contractororgrank_idx2', 'ru_contractororganizationranking', 'RatingCriteriaID', null);
