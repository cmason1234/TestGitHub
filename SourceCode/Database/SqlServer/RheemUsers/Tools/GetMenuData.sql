--  Run this against the Production Database, save the output and run against your database
--  This will delete your existing menus and give you new ones. 
 
 Use [RheemUsers]
 GO
 
  Select 'Truncate table Menu'
  Select 'GO'
  select 'Insert into Menu (MenuID, MenuType, Label, URL, Target, MenuOrder, ParentID, CreateDateTime__Gen, UpdateDateTime__Gen) values(''' + 
      convert(varchar(50), [MenuID]) + ''', '''+
      [MenuType] + ''', '''+
      [Label] +''', '''+
      isnull([URL], '') +''', '''+
      isnull([Target], '') +''', '''+
      convert(varchar(50), [MenuOrder]) +''', '''+
      convert(varchar(50), [ParentID]) +''', GetDate(), GetDate()) '
      FROM Menu
   Select 'GO' 
   
   Select 'Truncate table MenuApplicationRole'
   Select 'GO'
   Select 'Insert into MenuApplicationRole (MenuApplicationRoleID, MenuID, ApplicationRoleID, CreateDateTime__Gen, UpdateDateTime__Gen) values(''' + 
       convert(varchar(50), MenuApplicationRoleID) + ''', ''' +
       CONVERT(varchar(50), MenuID) + ''', ''' +
       CONVERT(varchar(50), ApplicationRoleID) + ''', GetDate(), GetDate()) '
       From MenuApplicationRole
    
   Select 'Truncate table MenuOrganizationType'
   Select 'GO'
   Select 'Insert Into MenuOrganizationType (MenuOrganizationTypeID, MenuID, OrganizationTypeID, CreateDateTime__Gen, UpdateDateTime__Gen) values(''' + 
       CONVERT(varchar(50), MenuOrganizationTypeID) + ''', ''' +
       CONVERT(varchar(50), MenuID) + ''', ''' +
       CONVERT(varchar(50), OrganizationTypeID) + ''', GetDate(), GetDate()) '
       From MenuOrganizationType
   Select 'GO'
   
   Select 'Truncate table MenuWebSite'
   Select 'GO'
   Select 'Insert Into MenuWebSite (MenuWebSiteID, MenuID, RheemWebSiteID, CreateDateTime__Gen, UpdateDateTime__Gen) values(''' + 
       Convert(varchar(50), MenuWebSiteID) + ''', ''' +
       Convert(varchar(50), MenuID) + ''', ''' +
       Convert(varchar(50), RheemWebSiteID) + ''', GetDate(), GetDate()) '
       from MenuWebSite
   Select 'GO'
   
   