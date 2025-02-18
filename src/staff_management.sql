-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Staff Management Queries

-- 1. List all staff members by role
-- TODO: Write a query to list all staff members by role

SELECT staff_id, first_name, last_name, position AS role FROM staff; -- Select these roles from staff and redescribes position to role

-- 2. Find trainers with one or more personal training session in the next 30 days
-- TODO: Write a query to find trainers with one or more personal training session in the next 30 days

SELECT 
    s.staff_id AS trainer_id, -- Redescribes staff_id from staff table to trainer_id
    s.first_name || ' ' || s.last_name AS trainer_name, -- Concatenates the staff member's first name and last name from the staff table to get the trainer_name
    COUNT(pts.session_id) AS session_count -- Counts the number of personal_training_sessions sessions_id and redescribes it as session_count
FROM 
    staff s
JOIN 
    personal_training_sessions pts ON s.staff_id = pts.staff_id -- Joins staff table with personal_training_sessions from shared staff_id column
WHERE 
    s.position = 'Trainer' -- Filters the results to only include staff that have the position 'Trainer' 
    AND DATE(pts.session_date) BETWEEN DATE('now') AND DATE('now', '+30 days') -- Filters results to display only sessions within the next 30 days
GROUP BY 
    trainer_id, trainer_name
HAVING 
    session_count >= 1  -- Display results where trainers that have at least one session
ORDER BY 
    session_count DESC; -- Trainers with more upcoming sessions appear first