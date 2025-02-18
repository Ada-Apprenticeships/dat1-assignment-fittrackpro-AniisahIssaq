-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Membership Management Queries

-- 1. List all active memberships
-- TODO: Write a query to list all active memberships

SELECT 
    m.member_id, 
    m.first_name, 
    m.last_name, 
    ms.type AS membership_type,
    m.join_date
FROM 
    members m
JOIN 
    memberships ms ON m.member_id = ms.member_id
WHERE 
    ms.status = 'Active';

-- 2. Calculate the average duration of gym visits for each membership type
-- TODO: Write a query to calculate the average duration of gym visits for each membership type

SELECT 
    ms.type AS membership_type, 
    CAST(AVG((JULIANDAY(a.check_out_time) - JULIANDAY(a.check_in_time)) * 24 * 60) AS INTEGER) AS avg_visit_duration_minutes
FROM 
    memberships ms
JOIN 
    members m ON ms.member_id = m.member_id
JOIN 
    attendance a ON m.member_id = a.member_id
GROUP BY 
    membership_type;


-- 3. Identify members with expiring memberships this year
-- TODO: Write a query to identify members with expiring memberships this year

SELECT 
    m.member_id, 
    m.first_name, 
    m.last_name, 
    m.email, 
    ms.end_date
FROM 
    members m
JOIN 
    memberships ms ON m.member_id = ms.member_id
WHERE 
    ms.end_date BETWEEN DATE('now') AND DATE('now', '+1 year')
ORDER BY 
    ms.end_date;