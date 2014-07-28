select -1, 'Delete from ru_APIAccessKey;'
union
select 0, 'insert into ru_APIAccessKey (APIAccessKeyID, AccessKey, SecretKey, Active, KeyOwner, KeyType, CreateDateTime__Gen, UpdateDateTime__Gen) values (''' +
convert(varchar(64), APIAccessKeyID) + ''', ''' + AccessKey + ''', ''' + SecretKey + ''', ' + convert(varchar(1), Active) + ', ''' + convert(varchar(64), KeyOwner) + ''', ''' + KeyType + ''', Now(), Now());'
from APIAccessKey
union
select 1, 'Delete from ru_APIMaster;'
union
select 2, 'insert into ru_APIMaster(APIMasterID, APIName, CreateDateTime__Gen, UpdateDateTime__Gen) values (''' + convert(varchar(64), APIMasterID) + ''', ''' + convert(varchar(64), APIName) + 
''', NOW(), NOW());'
from APIMaster
union
select 3, 'Delete from ru_APIRoute;'
union
select 4, 'insert into ru_APIRoute(APIRouteID, APIMasterID, RoutePath, HttpMethod, DefaultAccess, ActionName, CreateDateTime__Gen, UpdateDateTime__Gen) values (''' +
convert(varchar(64), APIRouteID) + ''', ''' + convert(varchar(64), APIMasterID) + ''', ''' + RoutePath + ''', ''' +
HttpMethod + ''', 0, ''' + ActionName + ''', NOW(), NOW());'
from APIRoute
union
select 5, 'Delete from ru_APIAccessMatrix;'
union
select 6, 'Insert into ru_APIAccessMatrix(APIAccessMatrixID, APIAccessKeyID, APIRouteID, Method, CreateDateTime__Gen, UpdateDateTime__Gen) values (''' +
convert(varchar(64), APIAccessMatrixID) + ''', ''' + convert(varchar(64), APIAccessKeyID) + ''', ''' + convert(varchar(64), APIRouteID) + ''', ''' +
Method + ''', NOW(), NOW());'
from APIAccessMatrix

