USE [Builder]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetListOfDirectBuildersByYear]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetListOfDirectBuildersByYear]
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
CREATE PROCEDURE [dbo].[GetListOfDirectBuildersByYear]
    -- Add the parameters for the stored procedure here
    @Year int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT DISTINCT b.BuilderName,
                    a.BuilderID,
                    b.Address,
                    b.City,
                    b.State,
                    b.ZipCode as PostalCode,
                    b.Phone 
    FROM Builder..BuilderJobSites a,
         Builder..Builder b 
    WHERE(year(a.CompletedDate) = @Year And a.BuilderID = b.BuilderID) 
    ORDER BY b.BuilderName

END
GO
