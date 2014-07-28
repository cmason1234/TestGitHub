﻿USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonHasJobFunction]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PersonHasJobFunction]
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
CREATE PROCEDURE [dbo].[PersonHasJobFunction] 
    -- Add the parameters for the stored procedure here
    @PersonID uniqueidentifier,
    @JobFunctionDescription varchar(50)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    SELECT COUNT(*) AS numRows 
    FROM  rheemusers..PersonDepartmentJob pdj, 
          rheemusers..DepartmentJobFunction djf, 
          rheemusers..JobFunction jf 
    WHERE pdj.PersonID = @PersonID and 
          pdj.DepartmentJobFunctionID = djf.DepartmentJobFunctionID and 
          djf.JobFunctionID = jf.JobFunctionID  and 
          jf.Description = @JobFunctionDescription

END
GO
