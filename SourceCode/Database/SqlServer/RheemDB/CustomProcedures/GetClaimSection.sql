USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClaimSection]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClaimSection]
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
CREATE PROCEDURE [dbo].[GetClaimSection] 
	-- Add the parameters for the stored procedure here
	@YearSelected int,
	@ProgramSelected varchar(50),
	@SpecialProgram bit,
	@Discretionary bit
AS
BEGIN
DECLARE @sql nvarchar(MAX),
        @paramlist  nvarchar(50)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @ProgramSelected = 'GDP' 
	 BEGIN
         SELECT @sql = 'SELECT * 
		                FROM rheemdb..EC_ClaimSection
                        WHERE GDPSection=1 and 
						SectionName not in (''Credits'' '

	    IF @SpecialProgram = 1
	     BEGIN
            SELECT @sql = @sql + ',''Special Programs'' '
	     END 
         IF @Discretionary = 1
		 BEGIN
            SELECT @sql = @sql + ',''DSM Discretionary'' '
		 END

         SELECT @sql = @sql + ') and 
                               GDPYear = @YearSelected 
                               ORDER BY SectionName'

     END

	ELSE
     BEGIN
         SELECT @sql =  'SELECT * 
		                 FROM rheemdb..EC_ClaimSection
                         WHERE TCSection=1  and
                               SectionName <> ''Credits'' and
                               GDPYear= @YearSelected
                         ORDER BY SectionName'
      END
  
	 SELECT @paramlist = '@yearselected int '      

     EXEC sp_executesql @sql, @paramlist, @YearSelected

END
GO
