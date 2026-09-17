-- Create the employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    department VARCHAR(50),
    status VARCHAR(20) -- 'Active', 'Terminated', 'On Leave'
);

-- Create the system roles table
CREATE TABLE system_roles (
    role_id INT PRIMARY KEY,
    role_name VARCHAR(50), -- e.g., 'Standard User', 'HR Admin', 'IT SuperAdmin'
    risk_level VARCHAR(10) -- 'Low', 'Medium', 'High'
);

-- Create the user access assignments table (mapping employees to roles)
CREATE TABLE user_access_assignments (
    assignment_id INT PRIMARY KEY,
    employee_id INT,
    role_id INT,
    date_assigned DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (role_id) REFERENCES system_roles(role_id)
);

-- Insert sample mock data to test our audits
INSERT INTO employees VALUES (101, 'Finance', 'Active');
INSERT INTO employees VALUES (102, 'HR', 'Terminated'); -- Security Risk!
INSERT INTO employees VALUES (103, 'Engineering', 'Active');
INSERT INTO employees VALUES (104, 'Operations', 'Terminated'); -- Security Risk!

INSERT INTO system_roles VALUES (1, 'Standard User', 'Low');
INSERT INTO system_roles VALUES (2, 'HR Admin', 'Medium');
INSERT INTO system_roles VALUES (3, 'IT SuperAdmin', 'High');

INSERT INTO user_access_assignments VALUES (1, 101, 1, '2025-01-15');
INSERT INTO user_access_assignments VALUES (2, 102, 2, '2024-06-10'); -- Terminated user still has HR Admin access!
INSERT INTO user_access_assignments VALUES (3, 103, 3, '2025-03-01');
INSERT INTO user_access_assignments VALUES (4, 104, 3, '2023-11-20'); -- Terminated user still has SuperAdmin access!
