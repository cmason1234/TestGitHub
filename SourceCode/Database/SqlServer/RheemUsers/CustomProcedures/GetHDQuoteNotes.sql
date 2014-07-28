USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetHDQuoteNotes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetHDQuoteNotes]
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
CREATE PROCEDURE [dbo].[GetHDQuoteNotes] 
    -- Add the parameters for the stored procedure here
    @HDQuoteID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    Select a.HDQuoteNoteID,a.SeqNumIdentity,a.NoteTimeStamp,a.NoteText,b.FirstName+' '+b.LastName AS NoteOwner
    FROM rheemusers..HDQuoteNote a, rheemusers..Person b
    WHERE a.HDQuoteID = @HDQuoteID and a.PersonID=b.PersonID
    ORDER BY SeqNumIdentity

END
GO
