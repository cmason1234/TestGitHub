USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorOrganization]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorOrganization]
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDistributorOrganization] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
	@ProgramValue varchar(50),
    @Year int
AS
BEGIN
	
DECLARE @strSql nvarchar(MAX),
        @paramlist  nvarchar(4000)
	 SET NOCOUNT ON
	
	 IF @ProgramValue = 'PROSTOCK' 
	   BEGIN

         SELECT @strSql = 'SELECT * 
		                   FROM rheemusers..MyOrganizations mo, rheemusers..organization o, rheemusers..DistributorOrganization do 
                           WHERE mo.OrganizationID   = o.OrganizationId and 
                                 mo.personID         = @PersonId and 
                                 o.OrganizationType  = ''Distributor'' and 
                                 o.OrganizationID    = do.OrganizationId and  
                                 o.OrganizationName <> '''' and o.OrganizationName is not null'
		 IF @Year > 0
           BEGIN
--               If yearValue.Length > 0 Then
             SELECT @strSql = @strSql + ' and o.OrganizationId in (
     	                                  SELECT OrganizationId 
					    			      FROM rheemdb..EC_Claims
                                          WHERE ClaimYear      = @Year and 
                                                Program        = ''PROSTOCK'' and 
                                                TotalClaim     > 0 )'
		   END
            
		 ELSE
     	   BEGIN
             SELECT @strSql = @strSql + ' and do.ProstockStores=''1'' '
           END

         SELECT @strSql = @strSql + ' ORDER BY o.OrganizationName '
	   END

	 ELSE IF @ProgramValue = 'SPECIAL'
	   BEGIN
         SELECT @strSql = 'SELECT * 
                           FROM rheemusers..MyOrganizations mo, rheemusers..organization o, rheemusers..DistributorOrganization do 
                           WHERE mo.OrganizationID   = o.OrganizationId and 
                                 mo.personID         = @PersonId and 
                                 o.OrganizationType  = ''Distributor'' and 
                                 o.OrganizationID    = do.OrganizationId and  
                                 do.COOPEligible        = ''1'' and  
                                 o.OrganizationName <> '''' and o.OrganizationName is not null '

		 IF @Year > 0
	       BEGIN
--                If yearValue.Length > 0 Then

             SELECT @strSql = @strSql + ' and o.OrganizationId in (
                                          SELECT OrganizationId 
							              FROM rheemdb..EC_Claims 
                                          WHERE ClaimYear      = @Year and 
                                                Program        = ''SPECIAL'' and 
                                                TotalClaim     > 0 )'
           END
           SELECT @strSql = @strSql + '  ORDER BY o.OrganizationName'

	   END
	 ELSE IF @Year > 0

	   BEGIN
--            ElseIf yearValue.Length > 0 Then
--   do.Corporate        = ''1'' and 

         SELECT @strSql = 'SELECT * 
		                   FROM rheemusers..MyOrganizations mo, rheemusers..organization o, rheemusers..DistributorOrganization do 
                           WHERE mo.OrganizationID   = o.OrganizationId and 
                                 mo.personID         = @PersonId and 
                                 o.OrganizationType  = ''Distributor'' and 
                                 o.OrganizationID    = do.OrganizationId and         
           do.COOPEligible    = ''1'' and  								 
                                 o.OrganizationName <> '''' and o.OrganizationName is not null  and 
                                 ( 1=1  '

		SELECT @strSql = @strSql + ' or o.OrganizationId in (
     	                                  SELECT OrganizationId 
					    			      FROM rheemdb..EC_Claims
                                          WHERE ClaimYear      = @Year and 
                                                Program        = ''PROSTOCK'' and 
                                                TotalClaim     > 0 )'						   


		SELECT @strSql = @strSql + ' or o.OrganizationId in (
                                          SELECT OrganizationId 
							              FROM rheemdb..EC_Claims 
                                          WHERE ClaimYear      = @Year and 
                                                Program        = ''SPECIAL'' and 
                                                TotalClaim     > 0 )'

												
         SELECT @strSql = @strSql + ' )  ORDER BY o.OrganizationName'
	   END
	 ELSE 
	   BEGIN
         SELECT @strSql = 'SELECT * FROM rheemusers..MyOrganizations mo, rheemusers..organization o, rheemusers..DistributorOrganization do 
                           WHERE mo.OrganizationID   = o.OrganizationId and 
                                 mo.personID         = @PersonId and 
                                 o.OrganizationType  = ''Distributor'' and 
                                 o.OrganizationID    = do.OrganizationId and  
                                 do.COOPEligible    = ''1'' and  
                                 o.OrganizationName <> '''' and o.OrganizationName is not null  
                           ORDER BY o.OrganizationName'
	   END

	 SELECT @paramlist = '@personID       uniqueidentifier,    
			              @programValue   varchar(50),      
			              @year           int '      

     EXEC sp_executesql @strSql, @paramlist, @PersonID, @ProgramValue, @Year

END
GO
