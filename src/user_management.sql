-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- User Management Queries

-- 1. Retrieve all members
-- TODO: Write a query to retrieve all members

SELECT member_id, first_name, last_name, email, join_date FROM members; -- Select these rows from members

-- 2. Update a member's contact information
-- TODO: Write a query to update a member's contact information

UPDATE 
    member 
SET 
    phone_number = '555-9876'
SET 
    email = 'emily.jones.updated@email.com'
WHERE 
    member_id = '5'; -- Updates these rows for only the member with member_id '5'

-- 3. Count total number of members
-- TODO: Write a query to count the total number of members

SELECT COUNT(*) FROM members; -- Count the number of rows in members

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations

SELECT 
    m.member_id, 
    m.first_name, 
    m.last_name, 
    COUNT(ca.member_id) AS registration_count -- Count the number of rows (member_id) in class_attendance to get the number of class registrations per member
FROM 
    members m
JOIN 
    class_attendance ca ON m.member_id = ca.member_id -- Combines data from members table and class_attendance table
GROUP BY 
    m.member_id, m.first_name, m.last_name -- Count registrations for each member separately
ORDER BY 
    registration_count DESC -- Puts the number with the highest registration count at the top
LIMIT 
    1; -- Selects only the first row, which represents the number with the most class registrations

-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations

SELECT 
    m.member_id, 
    m.first_name, 
    m.last_name, 
    COUNT(ca.member_id) AS registration_count
FROM 
    members m
JOIN 
    class_attendance ca ON m.member_id = ca.member_id
GROUP BY 
    m.member_id, m.first_name, m.last_name
ORDER BY 
    registration_count ASC -- Puts the number with the least class registrations at the top
LIMIT 
    1; -- Selects only the first row, which represents the number with the least class registrations

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class

SELECT 
  CAST(COUNT(DISTINCT ca.member_id) AS REAL) * 100 / COUNT(DISTINCT m.member_id) AS percentage_attended -- Counts number of distinct members who have at least one entry in class_attendance table
FROM 
  members m
LEFT JOIN 
  class_attendance ca ON m.member_id = ca.member_id; -- Includes all members from the members table even if they haven't attended any classes