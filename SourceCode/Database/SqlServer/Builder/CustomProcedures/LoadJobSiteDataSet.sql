USE [Builder]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadJobSiteDataSet]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[LoadJobSiteDataSet]
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
CREATE PROCEDURE [dbo].[LoadJobSiteDataSet] 
    -- Add the parameters for the stored procedure here
    @JobSiteID uniqueidentifier
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    Select *
    FROM Builder..BuilderJobSites bj join Builder..BuilderLots bl on 
         bj.JobSiteID = bl.JobSiteID join Builder..Builder b on
         bj.BuilderID = b.BuilderID join Builder..BuilderRebate br on 
         bj.RebateID = br.BuilderRebateID join Builder..EquipmentConfiguration ec on 
         bl.EquipmentConfigurationID = ec.EquipmentConfigurationID 
    WHERE bj.JobSiteID = @JobSiteID
    ORDER BY bl.SeqNum

END
GO
