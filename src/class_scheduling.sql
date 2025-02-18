-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Class Scheduling Queries

-- 1. List all classes with their instructors
-- TODO: Write a query to list all classes with their instructors

SELECT 
    c.class_id,
    c.name AS class_name,
    s.first_name || ' ' || s.last_name AS instructor_name -- Concatenates the instructor's first and last names from the staff table and aliases the result as instructor_name
FROM 
    classes c
JOIN 
    class_schedule cs ON c.class_id = cs.class_id -- Joins class_schedule table with classes using the shared class_id column
JOIN 
    staff s ON cs.staff_id = s.staff_id; -- Joins result of the previous join with the staff table

-- 2. Find available classes for a specific date
-- TODO: Write a query to find available classes for a specific date

SELECT 
    c.class_id,
    c.name,
    cs.start_time,
    cs.end_time,
    (c.capacity - COUNT(ca.member_id)) AS available_spots -- Subtracts the number of current registrations from the capacity to get the number of available spots
FROM 
    classes c
LEFT JOIN 
    class_schedule cs ON c.class_id = cs.class_id -- Joins classes to their schedule entries
LEFT JOIN 
    class_attendance ca ON cs.schedule_id = ca.schedule_id -- Joins scheduled entries with attendance records
WHERE 
    cs.start_time LIKE '2025-02-01%' -- Filters for classes that are happening today
GROUP BY 
    c.class_id, c.name, cs.start_time, cs.end_time, c.capacity
HAVING 
    available_spots > 0; -- Filters out classes that are full

-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class

INSERT INTO class_attendance (schedule_id, member_id, attendance_status) -- Insert into class_attendance table these rows with the below values
SELECT 
    cs.schedule_id, 
    11, 
    'Registered' 
FROM 
    class_schedule cs 
WHERE 
    cs.class_id = 3  -- Filters data to find class_id '3' and start time is '2025-02-01%'
    AND cs.start_time LIKE '2025-02-01%'
LIMIT 
    1;

-- 4. Cancel a class registration
-- TODO: Write a query to cancel a class registration

DELETE FROM class_attendance -- Delete these values from the class attendance table
WHERE 
    schedule_id = 7  
    AND member_id = 
LIMIT 
    1; -- Delete only one row

-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes

SELECT 
    c.class_id, 
    c.name AS class_name, 
    COUNT(ca.member_id) AS registration_count -- Counts the number of registrations per class
FROM 
    classes c
JOIN 
    class_schedule cs ON c.class_id = cs.class_id -- Joins classes with their class_schedule from shared class_id
LEFT JOIN 
    class_attendance ca ON cs.schedule_id = ca.schedule_id -- Joins attendance records with schedule_ids to include all classes, even if they have no registrations
GROUP BY 
    c.class_id, c.name
ORDER BY 
    registration_count DESC -- Puts the classes with the most class registrations at the top
LIMIT 
    5; -- Limits output the the top 5 most popular classes

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member

SELECT 
    CAST(COUNT(DISTINCT ca.schedule_id) AS REAL) / COUNT(DISTINCT ca.member_id) AS average_classes_per_member -- Counts the total number of distinct class schedules attended and counts the distinct members who have attended at least one class
FROM  -- Divides the total class attendances by the total number of members to calculate the average number of classes per member
    class_attendance ca;