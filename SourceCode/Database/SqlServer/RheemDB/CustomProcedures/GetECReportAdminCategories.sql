USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClaimsSectionReport]') AND type in (N'P', N'PC'))
  DROP PROCEDURE [dbo].[GetClaimsSectionReport]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetECReportAdminCategories]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetECReportAdminCategories]
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
CREATE PROCEDURE [dbo].[GetECReportAdminCategories] 
	-- Add the parameters for the stored procedure here
	@YearSelected int,
	@ProgramValue varchar(50)
AS
BEGIN
	 -- SET NOCOUNT ON added to prevent extra result sets from
	 -- interfering with SELECT statements.
	 SET NOCOUNT ON;

     -- Insert statements for procedure here
     SELECT * 
	    FROM  rheemdb..EC_ClaimSection cs
		  INNER JOIN rheemdb..EC_ClaimSectionCategory csc ON cs.ClaimSectionID = csc.ClaimSectionID
       WHERE  cs.GDPYear=@YearSelected  AND
	      ((@ProgramValue='GDP' AND cs.GDPSection = 1) OR
		   (@ProgramValue = 'TC' AND cs.TCSection = 1) or 
		   (@ProgramValue = 'WHCOOP' AND cs.WHSection = 1)  
		   )
        order by cs.GDPSection desc , cs.TCSection desc, cs.ProStockSection desc, 
		      cs.SpecialProgramSection desc,  cs.SectionName, csc.CategoryName

END
GO
