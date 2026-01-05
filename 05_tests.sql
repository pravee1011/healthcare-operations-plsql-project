SET SERVEROUTPUT ON

-- Test 1: schedule appointment creates both appointment and billing
BEGIN
  healthcare_ops.schedule_appointment(1, 1, SYSDATE+10, 'Scheduled', 1500);
  DBMS_OUTPUT.PUT_LINE('Test 1: scheduled appointment created');
END;
/
SELECT Appt_ID, Patient_ID, Doctor_ID, Appt_Date, Status
FROM Appointments
WHERE Patient_ID = 1
ORDER BY Appt_ID DESC FETCH FIRST 1 ROWS ONLY;

SELECT Appt_ID, Patient_ID, Amount, Payment_Status, Bill_Date
FROM Billing
WHERE Patient_ID = 1
ORDER BY Bill_ID DESC FETCH FIRST 1 ROWS ONLY;

-- Test 2: trigger updates billing when status changes
BEGIN
  UPDATE Appointments SET Status='Completed' WHERE Appt_ID = 1;
  DBMS_OUTPUT.PUT_LINE('Test 2: updated appointment status to Completed for Appt_ID=1');
END;
/
SELECT Appt_ID, Payment_Status, Bill_Date FROM Billing WHERE Appt_ID = 1;

-- Test 3: compute doctor load
DECLARE v NUMBER;
BEGIN
  v := healthcare_ops.compute_doctor_load(1, SYSDATE-30, SYSDATE+30);
  DBMS_OUTPUT.PUT_LINE('Test 3: doctor 1 load = '||v);
END;
/

-- Test 4: get patient history
DECLARE v_hist healthcare_ops.t_medrec_tab;
BEGIN
  healthcare_ops.get_patient_history(1, SYSDATE-365, SYSDATE, v_hist);
  DBMS_OUTPUT.PUT_LINE('Test 4: patient 1 history rows = '||v_hist.COUNT);
END;
/

-- Test 5: bulk add medical records
DECLARE
  v_new healthcare_ops.t_medrec_tab := healthcare_ops.t_medrec_tab();
BEGIN
  v_new.EXTEND(2);
  v_new(1).patient_id := 1; v_new(1).doctor_id := 1;
  v_new(1).diagnosis := 'Cold'; v_new(1).prescription := 'Warm fluids'; v_new(1).record_date := SYSDATE;

  v_new(2).patient_id := 2; v_new(2).doctor_id := 2;
  v_new(2).diagnosis := 'Back pain'; v_new(2).prescription := 'Physio'; v_new(2).record_date := SYSDATE;

  healthcare_ops.bulk_add_med_records(v_new);
  DBMS_OUTPUT.PUT_LINE('Test 5: bulk added 2 records');
END;
/
SELECT COUNT(*) AS total_records FROM Medical_Records;
