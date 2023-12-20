select 'example@email.com' ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'; -- Checks if the string is a valid email.
select substring(
    'http://www.example.com/page' from '://([^/]+)'
) = 'www.example.com'; -- Extracts domain from URL.
select 'www.example.net' ~ '\.org$'; -- Checks if the URL ends with .org
select 'The quick brown fox' ~ '\mbrown\b'; -- Checks if 'brown' is a word in the string.
select '192.168.300.1' ~ '^(\d{1,3}\.){3}\d{1,3}$'; -- Checks if the string is a valid IPv4 address.
select 'g3h4' ~ '^[A-Fa-f0-9]+$'; -- Checks if the string is a valid hexadecimal.
select '2023/04/01' ~ '^\d{4}-\d{2}-\d{2}$'; -- Validates date format YYYY-MM-DD.
select '123-456-789' ~ '^\d{3}-\d{2}-\d{4}$'; -- Validates a social security number format.
select '(123) 456-7890' ~ '^\(\d{3}\) \d{3}-\d{4}$'; -- Validates a US phone number format.
select 'abcxyz' ~ '[0-9]+'; -- Checks if there are any digits in the string.
select 'password' ~ '^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'; -- Validates a strong password.
select 'hello' ~ '^[A-Z]+$'; -- Checks if the string is in uppercase.
select 'abc_' ~ '^abc%'; -- Checks if the string is a SQL-like pattern.
select '123456' ~ '^\d{5}$'; -- Validates a 5-digit ZIP code.
select 'www.example.com' ~ '^https?://[a-z0-9.-]+(\.[a-z]{2,})+$'; -- Validates a URL format.
select '1234-5678-9012-3456' ~ '^\d{4}-\d{4}-\d{4}-\d{4}$'; -- Validates a credit card number format.
select 'image.png' ~ '\.pdf$'; -- Checks if the file has a .pdf extension.
select '' ~ '^\s+$'; -- Checks if the string contains only spaces.
select 'XYZ7890' ~ '^[A-Z]{3}-\d{4}$'; -- Validates a license plate format.
select 'abc-123' ~ '^[A-Za-z0-9]+$'; -- Checks if the string is alphanumeric.
