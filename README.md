# Healthcare Management System – Oracle PL/SQL Project

## Project Overview
This project is a **Healthcare Management System** built using **Oracle PL/SQL**, designed to simulate real-world hospital and clinic database operations.  
It focuses on appointment scheduling, billing management, and maintaining patient medical records through a single, well-structured PL/SQL package.

The project demonstrates how business logic can be centralized at the database layer using **packages, collections, and bulk processing techniques**.

---

## Why This Project
- Reflects **real-world healthcare workflows** commonly handled in enterprise systems
- Demonstrates **advanced PL/SQL concepts** beyond basic CRUD operations
- Shows how database logic can be made **modular, reusable, and scalable**
- Emphasizes **performance optimization** using BULK COLLECT and FORALL

---

## Technologies Used
- Oracle Database
- Oracle PL/SQL
- SQL Developer / SQL*Plus

---

## Project Structure
```text
Healthcare-PLSQL-Project/
│
├── ddl/
│   ├── 01_tables.sql
│
├── dml/
│   ├── 03_inserts.sql
│
├── packages/
│   ├── 04_package.sql
│
├── test_scripts/
│   ├── 05_tests.sql
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


## 🔧 Enhancements Based on Code Review

This project was enhanced after receiving code review feedback to improve database design, eliminate redundancy, and incorporate real-world features.

---

### 🔹 1. Database Normalization

* Introduced a **DEPARTMENTS** table
* Replaced text-based department field with **DEPARTMENT_ID (Foreign Key)** in DOCTORS
* Ensures better data integrity and follows **3rd Normal Form (3NF)**

---

### 🔹 2. Removal of Redundant Data

* Removed `PATIENT_ID` from BILLING table
* Patient details are now derived via APPOINTMENTS
* Prevents duplication and update anomalies

---

### 🔹 3. Appointment Status Tracking

* Added `STATUS` column in APPOINTMENTS
* Supports full lifecycle tracking:

  * Scheduled
  * Confirmed
  * Completed
  * Cancelled

---

### 🔹 4. Audit Logging using Trigger

* Created `APPOINTMENT_STATUS_HISTORY` table
* Implemented trigger `TRG_APPOINTMENT_STATUS`
* Automatically logs:

  * Status updates
  * Timestamp
  * User who performed the update

---

### 🔹 5. PL/SQL Package (Business Logic Layer)

Created package **HEALTHCARE_PKG** to centralize operations:

* `UPDATE_APPOINTMENT_STATUS`
  → Safely updates appointment status with validation

* `GET_PATIENT_FROM_BILLING`
  → Retrieves patient details dynamically from billing

---

### 🔹 6. Reporting View

* Created `BILLING_DETAILS` view
* Simplifies reporting by joining billing and appointment data

---

### 💡 Outcome

These enhancements improved:

* Data consistency
* Maintainability
* Real-world applicability
* Alignment with best database design practices

