-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Attendance Tracking Queries

-- 1. Record a member's gym visit
-- TODO: Write a query to record a member's gym visit

INSERT INTO attendance (member_id, location_id, check_in_time) -- Insert into the attendance table in these columns the below values
VALUES (
    7, 
    1,  
    (SELECT STRFTIME('%Y-%m-%d %H:%M:%S'))
);

-- 2. Retrieve a member's attendance history
-- TODO: Write a query to retrieve a member's attendance history

SELECT 
    STRFTIME('%Y-%m-%d', check_in_time) AS visit_date, -- Extracts the date from check in/out column and formats it as 'YYYY-MM-DD' to create a visit_date column
    check_in_time, 
    check_out_time
FROM 
    attendance
WHERE 
    member_id = 5 -- Filters the result to include only records for the member with an id of '5'
ORDER BY 
    visit_date, check_in_time; -- Orders the result by visit_date and check_in_time so that attendance history is displayed chronologically

-- 3. Find the busiest day of the week based on gym visits
-- TODO: Write a query to find the busiest day of the week based on gym visits

SELECT
    STRFTIME('%w', check_in_time) AS day_of_week, -- Selects the day of the week 
    COUNT(*) AS visit_count -- Counts all the rows in check_in_time to get the number of visits per day
FROM attendance
GROUP BY
    day_of_week -- Groups the results based on the day_of_week column, so count is calculated for each separate day
ORDER BY
    visit_count DESC -- Sorts the results in descending order so the busiest day appears first
LIMIT 1; -- Limits the results to the first row, which represents the busiest day of the week

-- 4. Calculate the average daily attendance for each location
-- TODO: Write a query to calculate the average daily attendance for each location

SELECT 
    l.name AS location_name,
    CAST(COUNT(DISTINCT a.member_id) AS REAL) / COUNT(DISTINCT STRFTIME('%Y-%m-%d', a.check_in_time)) AS avg_daily_attendance -- Selects the number of distinct members that check into a location and divides it by the total number of distinct days where wheck-in occured at each location to get the average daily attendance
FROM 
    locations l
LEFT JOIN 
    attendance a ON l.location_id = a.location_id
GROUP BY 
    l.location_id, l.name; -- Groups the results by location id and name, meaning that average daily attendance is calculated separately for each location