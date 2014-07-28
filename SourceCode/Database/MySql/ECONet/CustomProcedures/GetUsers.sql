USE econet;

drop procedure if exists GetUsers;

delimiter $$
create procedure GetUsers()
begin

	SELECT u.UserId,
		   u.FirstName,
		   u.MiddleName,
		   u.LastName,
		   u.EmailAddress,
		   u.Title,
		   u.Phone,
		   u.Fax,
		   u.MobilePhone,
		   u.Disabled,
		   u.PrimaryUserLocationId,
		   u.TemperatureDisplayMode,
		   u.CreateDateTime__Gen As CreateDateTime,
		   u.UpdateDateTiME__Gen As LastUpdateDateTime,
		   ul.UserLocationId,
		   ul.AddressLine1,
		   ul.AddressLine2,
		   ul.City,
		   ul.State,
		   ul.PostalCode,
		   ul.CountryId,
		   c.CountryCode,
		   ul.LocationName,
		   ul.TimeZone,
		   ul.CreateDateTime__Gen As LocationCreateDateTime,
		   ul.UpdateDateTiME__Gen As LocationLastUpdateDateTime
	FROM econet.user u
		INNER JOIN econet.userlocation ul ON ul.UserId=u.UserId
    INNER JOIN econet.country c ON c.CountryId=ul.CountryId;

end; $$
delimiter ';'

