DROP TABLE locations;
DROP TABLE members;
DROP TABLE staff;
DROP TABLE equipment;
DROP TABLE classes;
DROP TABLE class_schedule;
DROP TABLE memberships;
DROP TABLE attendance;
DROP TABLE class_attendance;
DROP TABLE payments ;
DROP TABLE personal_training_sessions;
DROP TABLE member_health_metrics;
DROP TABLE equipment_maintenance_log;

CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY,
    name TEXT,
    address, TEXT,
    phone_number TEXT,
    email TEXT,
    opening_hours TEXT
);

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    phone_number TEXT,
    date_of_birth DATE,
    join_date DATE,
    emergency_contact_name TEXT,
    emergency_contact_phone TEXT,
);

CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY,
    first_name TEXT, 
    last_name TEXT,
    email TEXT,
    phone_number TEXT,
    position TEXT,
    hire_date DATE,
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES location(location_id)
);

CREATE TABLE equipment (
    equipment_id INTEGER PRIMARY KEY,
    name TEXT,
    type TEXT,
    purchase_date DATE,
    last_maintenance_date DATE,
    next_maintenance_date DATE,
    location_id INTEGER, 
    FOREIGN KEY (location_id) REFERENCES location(location_id)
);

CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY,
    name TEXT,
    description TEXT,
    capacity TEXT,
    duration TEXT, 
    location_id INTEGER,
    FOREIGN KEY (location_id) REFERENCES location(location_id)
);

CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY,
    class_id INTEGER,
    staff_id INTEGER,
    start_time DATE,
    end_time DATE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
);

CREATE TABLE memberships (
    membership_id INTEGER PRIMARY KEY,	
    member_id INTEGER,	
    type TEXT,	
    start_date DATE,
    end_date DATE,
    status TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY,
    member_id INTEGER,
    location_id INTEGER,
    check_in_time DATE,
    check_out_time DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (location_id) REFERENCES location(location_id)
);

CREATE TABLE class_attendance (
    class_attendance_id	INTEGER PRIMARY KEY,
    schedule_id	INTEGER
    member_id INTEGER	
    attendance_status TEXT,
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,	
    member_id INTEGER,
    amount TEXT,
    payment_date DATE,	
    payment_method TEXT,
    payment_type TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE personal_training_sessions (
    session_id INTEGER PRIMARY KEY,
    member_id INTEGER,
    staff_id INTEGER, 
    session_date DATE,
    start_time TEXT,
    end_time TEXT,
    notes TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE member_health_metrics (
    metric_id INTEGER PRIMARY KEY,
    member_id INTEGER,
    measurement_date DATE,
    weight TEXT,
    body_fat_percentage TEXT,
    muscle_mass TEXT,
    bmi TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE equipment_maintenance_log (
    log_id INTEGER PRIMARY KEY,
    equipment_id INTEGER,
    maintenance_date DATE,
    description TEXT,
    staff_id INTEGER,
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);
