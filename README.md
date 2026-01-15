# 🏥 Healthcare Management System – Oracle PL/SQL Project

## 📌 Project Overview
This project is a **Healthcare Management System** built using **Oracle PL/SQL**, designed to simulate real-world hospital and clinic database operations.  
It focuses on appointment scheduling, billing management, and maintaining patient medical records through a single, well-structured PL/SQL package.

The project demonstrates how business logic can be centralized at the database layer using **packages, collections, and bulk processing techniques**.

---

## 🚀 Why This Project
- Reflects **real-world healthcare workflows** commonly handled in enterprise systems
- Demonstrates **advanced PL/SQL concepts** beyond basic CRUD operations
- Shows how database logic can be made **modular, reusable, and scalable**
- Emphasizes **performance optimization** using BULK COLLECT and FORALL
- Designed with **interview discussion and practical understanding** in mind

---

## 🧠 Technologies Used
- Oracle Database
- Oracle PL/SQL
- SQL Developer / SQL*Plus

---

## 🏗️ Project Structure
```text
Healthcare-PLSQL-Project/
│
├── ddl/
│   ├── appointments.sql
│   ├── billing.sql
│   └── medical_records.sql
│
├── packages/
│   ├── healthcare_ops_spec.sql
│   └── healthcare_ops_body.sql
│
├── test_scripts/
│   ├── schedule_appointment_test.sql
│   ├── patient_history_test.sql
│   └── bulk_insert_test.sql
│
└── README.md
```

## Database Objects Used
- Packages
- Records and Collections
- Bulk Collect and FORALL
- Exception handling
- Insert with RETURNING clause

## Package: healthcare_ops

### Function: compute_doctor_load
Returns number of appointments for a doctor between two dates.

### Procedure: schedule_appointment
- Schedules an appointment
- Automatically creates a billing record
- Handles cancelled appointments

### Procedure: get_patient_history
- Fetches patient medical history
- Uses BULK COLLECT into a collection

### Procedure: bulk_add_med_records
- Inserts multiple medical records at once
- Uses FORALL for performance

## Purpose of the project:
Designed to demonstrate real-world healthcare scenarios using PL/SQL best practices.
