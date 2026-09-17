-- AUDIT REPORT 1: Flag terminated employees who still hold active system access
SELECT 
    e.employee_id,
    e.department,
    e.status AS employment_status,
    sr.role_name,
    sr.risk_level,
    ua.date_assigned
FROM employees e
JOIN user_access_assignments ua ON e.employee_id = ua.employee_id
JOIN system_roles sr ON ua.role_id = sr.role_id
WHERE e.status = 'Terminated'
  AND sr.risk_level IN ('Medium', 'High');
