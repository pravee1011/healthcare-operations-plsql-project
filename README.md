# Healthcare PL/SQL Project
Healthcare management project using Oracle PL/SQL

## Overview
This project simulates a simple healthcare management system using Oracle PL/SQL.
It handles appointments, billing, and medical records efficiently.

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
