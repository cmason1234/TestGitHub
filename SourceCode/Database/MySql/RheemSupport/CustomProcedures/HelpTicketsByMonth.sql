USE support;

drop procedure if exists HelpTicketsByMonth;

delimiter $$
create procedure HelpTicketsByMonth()
begin
	select Year(TicketDate) as ticketYear, month(TicketDate) as ticketMonth, 
	  monthname(TicketDate) as ticketMonthName, count(*) as numTickets
	 from helpdeskticket 
	 group by month(TicketDate), Year(TicketDate), monthname(TicketDate)
	order by ticketyear, ticketMonth;

end; $$
delimiter ';'

