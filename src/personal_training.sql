-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Personal Training Queries

-- 1. List all personal training sessions for a specific trainer
-- TODO: Write a query to list all personal training sessions for a specific trainer

SELECT 
    pts.session_id,
    m.first_name || ' ' || m.last_name AS member_name, -- Concatenates the member's first and last names from the members table
    pts.session_date,
    pts.start_time,
    pts.end_time -- Retrieves session details from the personal_training_sessions tables
FROM 
    personal_training_sessions pts
JOIN 
    staff s ON pts.staff_id = s.staff_id -- Joins personal_training_sessions table with staff
JOIN 
    members m ON pts.member_id = m.member_id -- Previous join results are joined with members table
WHERE 
    s.first_name = 'Ivy' AND s.last_name = 'Irwin' -- Filters the results to only nclude sessions led by the staff member with the first name 'Ivy' and last name 'Irwin'
ORDER BY 
    pts.session_date, pts.start_time; -- Orders the results in chronological order
