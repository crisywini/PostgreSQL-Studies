//The time Data typeStorage sizeDescription Range
//timestamp 8 bytes Date and time 4713 BC to 294276 AD
//date 4 bytes Date (no time) 4713 BC to 5874897 AD
//time 8 bytes Time (no date) 00:00:00 to 24:00:00
//interval 16 bytes Time interval +/− 178,000,000 years <- ussually is for stats

//casting used like this
SELECT timestamp_column, CAST( timestamp_column AS varchar(10))
FROM date_time_types;

//And can be like this

SELECT timestamp_column :: varchar(10) // ONLY IN POSTGRESQL
FROM date_time_types;
