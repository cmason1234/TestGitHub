Use [RheemUsers]
GO

if Not Exists(select * from Organization where OrganizationID='7C490FE9-780F-499F-996C-C179B90E11EE')
    insert into organization (OrganizationID, OrganizationName, OrganizationType ) 
       values ('7C490FE9-780F-499F-996C-C179B90E11EE', 'Rheem MEA', 'RheemMEA')