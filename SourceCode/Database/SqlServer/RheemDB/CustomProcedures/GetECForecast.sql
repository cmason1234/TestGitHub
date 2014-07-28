USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetECForecast]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetECForecast]
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
CREATE PROCEDURE [dbo].[GetECForecast] 
	-- Add the parameters for the stored procedure here
	@DistributorValue uniqueidentifier,
	@Year int,
	@Column varchar(20)
AS
BEGIN
DECLARE @sql nvarchar(MAX),
        @paramlist  nvarchar(50)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF @Column = 'GDP' 
	  BEGIN
      -- Insert statements for procedure here
        SELECT GDPBudgetStatus
	    FROM rheemdb..EC_Forecast 
        WHERE OrganizationId = @DistributorValue and 
              GDPYear        = @Year
      END
	ELSE
	  BEGIN
        SELECT TCBudgetStatus
	    FROM rheemdb..EC_Forecast 
        WHERE OrganizationId = @DistributorValue and 
              GDPYear        = @Year
	  END

END
GO

