USE [TheTrainingNetwork]
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
/* ------------------------------------------------------------
   PROCEDURE:    GetClassReport
   
   Description:  Selects records
   
   AUTHOR:       Rheem Manufacturing, Brian White - 12/29/2010 12:53:31 PM
   ------------------------------------------------------------ */
If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetClassReport') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetClassReport;
        PRINT 'Dropped GetClassReport'
    END
GO
CREATE PROCEDURE [dbo].[GetClassReport]

As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int
    
    SELECT c.ClassID, c.Status, ct.ClassTypeStr,  convert(varchar(24),c.ClassDate,  101)  ClassDate, c.ClassLength, 
    c.LocationName, c.LocationStreet, c.LocationStreet2, c.LocationCity, c.LocationState, c.LocationZip, 
    sponsor, oSpon .OrganizationName Sponsor, c.contactPhone, c.ContactEMail , 
    c.ClassAddlInfo, 
    pIns.PersonID InstructorPersonID, pCon.PersonID  ContactPersonID, pSche.PersonID SchedulerPersonID, 
    pIns .FirstName + ' ' + pIns.LastName Instructor,
    pCon .FirstName + ' ' + pCon.LastName Contact,
    pCon .FirstName + ' ' + pCon.LastName Scheduler,  SchedulerName 
    FROM TheTrainingNetwork..Training_Classes c, rheemusers..person pIns,  rheemusers..person pCon, 
    rheemusers..Organization oSpon , rheemusers..Person pSche, TheTrainingNetwork..training_classtypes ct 
    WHERE c.ClassType    = ct.ClassType AND 
    c.InstructorID = pIns.PersonID AND 
    c.ContactID    = pCon.PersonID AND 
    c.SponsorID    = oSpon.OrganizationID AND 
    c.SchedulerID  = pSche.PersonID
    ORDER BY c.ClassDate DESC


End
GO


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetClassInstructors') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetClassInstructors;
        PRINT 'Dropped GetClassInstructors'
    END
GO
CREATE PROCEDURE [dbo].[GetClassInstructors]
As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int
        select personID, LastName +', ' + FirstName FullName  from rheemusers..person where personID in 
        (select distinct InstructorID  from TheTrainingNetwork ..training_classes )
order by LastName 

End
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetClassContacts') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetClassContacts;
        PRINT 'Dropped GetClassContacts'
    END
GO
CREATE PROCEDURE [dbo].GetClassContacts
As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int
    select personID, LastName +', ' + FirstName FullName  from rheemusers..person where personID in 
    (select distinct ContactID  from TheTrainingNetwork ..training_classes )
order by LastName 

End
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetClassSponsors') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetClassSponsors;
        PRINT 'Dropped GetClassSponsors'
    END
GO
CREATE PROCEDURE [dbo].GetClassSponsors
As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int
    select OrganizationID, OrganizationName from rheemusers..Organization where OrganizationID in 
    (select distinct SponsorID  from TheTrainingNetwork ..training_classes )
order by OrganizationName 


End
GO

If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetClassTypes') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetClassTypes;
        PRINT 'Dropped GetClassTypes'
    END
GO
CREATE PROCEDURE [dbo].[GetClassTypes]

As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int
    
    select * from TheTrainingNetwork..Training_ClassTypes order by ClassTypeStr 


End
GO


If EXISTS (Select * FROM SYSOBJECTS WHERE ID = OBJECT_ID('GetClassSchedulers') AND OBJECTPROPERTY(ID, 'IsProcedure') = 1)
    BEGIN
        DROP PROCEDURE GetClassSchedulers;
        PRINT 'Dropped GetClassSchedulers'
    END
GO
CREATE PROCEDURE [dbo].GetClassSchedulers
As
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    DECLARE @Err Int
        select personID, LastName +', ' + FirstName FullName  from rheemusers..person where personID in 
        (select distinct SchedulerID  from TheTrainingNetwork ..training_classes )
order by LastName 

End
GO

