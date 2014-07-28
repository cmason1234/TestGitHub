USE support;

drop procedure if exists HelpTicketsByCategoryForMonth;

delimiter $$
create procedure HelpTicketsByCategoryForMonth(
	IN p_monthNum int,
	IN p_yearValue int
)
begin
	select 1 as place, requestTypePart1 as Category, 
		'' as subCategory, 
		count(*) as numTickets
	  from helpdeskticket 
	  where month(TicketDate) = p_monthNum and year(TicketDate) = p_yearValue
	 group by RequestTypePart1
  union
	select 2, requestTypePart1 as Category, 
		coalesce(requestTypePart2, '') as subCategory, 
		count(*) as numTickets
	  from helpdeskticket 
	  where month(TicketDate) = p_monthNum and year(TicketDate) = p_yearValue
	 group by RequestTypePart1, requestTypePart2
	 order by place, Category, subCategory;

end; $$
delimiter ;
