-- Adds 4 hours to 20:00:00 and checks if it equals 00:00:00, returns false.
select '20:00:00'::time +
    interval '4 hours' =
    '00:00:00'::time;

-- Checks if current date is 2023-12-20.
select current_date = date '2023-12-20';

-- Checks if current time is greater than 23:59:59, returns false.
select current_time > time '23:59:59';

-- Checks if the age difference is more than a year, returns false.
select age(timestamp '2023-12-20', timestamp '2023-01-01') > interval '1 year';

-- Extracts hour from the current timestamp and checks if it's between 0 and 23.
select extract(hour from current_timestamp) between 0 and 23;

-- Converts to UTC and checks equality, returns false.
select '2023-12-20 15:00:00'::timestamp with time zone
       at time zone 'UTC' = '2023-12-20 15:00:00+00';

-- Checks if 1 day interval is equal to 24 hours.
select interval '1 day' = interval '24 hours';

-- Compares Tokyo time with Kolkata time.
select current_timestamp at time zone 'Asia/Tokyo'
       > current_timestamp at time zone 'Asia/Kolkata';

-- Subtracts dates and checks if the interval is 365 days, returns false in a leap year.
select '2023-12-31'::date - '2023-01-01'::date = 365;

-- Extracts day of the week from current date.
select extract(dow from current_date) between 0 and 6;

-- Checks if current_timestamp and now() are the same.
select current_timestamp is not distinct from now();

-- Compares two timestamps with different time zones.
select age(timestamp with time zone '2023-12-20 12:00:00-05',
           timestamp with time zone '2023-12-20 17:00:00+00') = interval '0 seconds';

-- Adds 1 month and subtracts 30 days from current date, checks if not equal to current date.
select current_date + interval '1 month' - interval '30 days' != current_date;

-- Checks if '24:00:00' is a valid time, returns false.
select '24:00:00'::time is not null;

-- Compares PST time with EST time.
select timezone('PST', now()) < timezone('EST', now());

-- Extracts epoch from 1 hour interval.
select extract(epoch from interval '1 hour') = 3600;

-- Subtracts 1 year from current date and compares with 2022-12-20.
select current_date - interval '1 year' < '2022-12-20'::date;

-- Converts timestamp without time zone to UTC, returns false.
select '2023-01-01 12:00:00'::timestamp without time zone
       at time zone 'UTC' = '2023-01-01 12:00:00+00';

-- Checks if doubling 1 day interval equals 48 hours.
select interval '1 day' * 2 = interval '48 hours';

