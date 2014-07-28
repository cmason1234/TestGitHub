Use [RheemUsers]
GO

if NOT EXISTS(Select * from Menu where Label='Restricted Words')
  Begin
    insert into Menu (MenuID, MenuType, Label, URL, MenuOrder, ParentID)
     (select NEWID(), 'MyRheemLeft', 'Restricted Words', 'AdminTools/RestrictedWordListEdit.aspx', 17, (select MenuID from rheemusers..menu where label='Web Admin Tools'))
END
