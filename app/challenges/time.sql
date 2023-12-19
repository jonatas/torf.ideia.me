select now() > current_date;
select now() - now() > interval '-1 seconds';
select now() - now() < interval '1 seconds';
select now() - now() = interval '0 milliseconds';
select time_bucket('1 day', now()) is not null;
select time_bucket('1 day', now()) - time_bucket('1 day', now()) > interval '-1 seconds';
select date_trunc('day', now()) = current_date;
