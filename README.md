# 🛡️ Enterprise Access Control & User Lifecycle Audit

## 📋 Overview
In modern enterprise environments, managing user lifecycles and maintaining strict access control is critical for security and compliance (e.g., SOC 2, ISO 27001). This project simulates an automated identity and access management (IAM) audit using **SQL**. 

The goal of this repository is to identify high-risk security vulnerabilities—specifically focusing on **orphaned accounts** and **Segregation of Duties (SoD) violations**—where former employees retain active system privileges.

---

## 🏗️ Database Schema Architecture
The relational database architecture models a standard corporate user directory mapped to system permissions:
* **`employees`**: Tracks employee department, lifecycle status (`Active`, `Terminated`, `On Leave`).
* **`system_roles`**: Defines access tiers and associated risk classifications (`Low`, `Medium`, `High`).
* **`user_access_assignments`**: Maps active user-to-role relationships with timestamp tracking.

---

## 🔍 Automated Compliance & Security Audits (`audit_queries.sql`)
The repository includes automated SQL scripts designed to flag critical compliance failures instantly. 

### Key Audit Check: High-Risk Terminated Access
This query filters the database to catch terminated personnel who still retain medium-to-high risk administrative access, preventing potential insider threats or unauthorized system breaches.

```sql
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
