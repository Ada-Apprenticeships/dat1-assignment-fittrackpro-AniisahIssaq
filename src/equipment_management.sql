-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

-- Equipment Management Queries

-- 1. Find equipment due for maintenance
-- TODO: Write a query to find equipment due for maintenance

SELECT 
    equipment_id, 
    name, 
    next_maintenance_date
FROM 
    equipment
WHERE 
    DATE(next_maintenance_date) BETWEEN DATE('now') AND DATE('now', '+30 days') -- Filters data so that the next_maintenance_date falls between now and the next 30 days
ORDER BY 
    next_maintenance_date; -- Orders the results in ascending order so that equipment due for maintenance sooner appears first

-- 2. Count equipment types in stock
-- TODO: Write a query to count equipment types in stock

SELECT 
    type AS equipment_type, -- Selects type and redescribes it as equipment_type
    COUNT(*) AS count -- Counts the total number of rows for each equipment type
FROM 
    equipment
GROUP BY 
    equipment_type; -- Groups results by equipment_type

-- 3. Calculate average age of equipment by type (in days)
-- TODO: Write a query to calculate average age of equipment by type (in days)

SELECT 
    type AS equipment_type, 
    CAST(AVG(JULIANDAY('now') - JULIANDAY(purchase_date)) AS INTEGER) AS avg_age_days -- Calculates the average age in days
FROM 
    equipment
GROUP BY 
    equipment_type;
