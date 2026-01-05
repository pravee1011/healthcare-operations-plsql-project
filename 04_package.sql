-- Package spec
CREATE OR REPLACE PACKAGE healthcare_ops AS
  TYPE t_medrec_rec IS RECORD (
    patient_id   NUMBER,
    doctor_id    NUMBER,
    diagnosis    VARCHAR2(200),
    prescription VARCHAR2(200),
    record_date  DATE
  );

  TYPE t_medrec_tab IS TABLE OF t_medrec_rec;

  FUNCTION compute_doctor_load(p_doctor_id IN NUMBER,
                               p_from_date IN DATE,
                               p_to_date   IN DATE)
  RETURN NUMBER;

  PROCEDURE schedule_appointment(p_patient_id IN NUMBER,
                                 p_doctor_id  IN NUMBER,
                                 p_appt_date  IN DATE,
                                 p_status     IN VARCHAR2 DEFAULT 'Scheduled',
                                 p_amount     IN NUMBER DEFAULT 1000);

  PROCEDURE get_patient_history(p_patient_id IN NUMBER,
                                p_from_date  IN DATE,
                                p_to_date    IN DATE,
                                p_history_out OUT t_medrec_tab);

  PROCEDURE bulk_add_med_records(p_records IN t_medrec_tab);
END healthcare_ops;
/

-- Package body
CREATE OR REPLACE PACKAGE BODY healthcare_ops AS

  FUNCTION compute_doctor_load(p_doctor_id IN NUMBER,
                               p_from_date IN DATE,
                               p_to_date   IN DATE)
  RETURN NUMBER IS
    v_count NUMBER := 0;
  BEGIN
    SELECT COUNT(*)
      INTO v_count
      FROM Appointments
     WHERE Doctor_ID = p_doctor_id
       AND Appt_Date BETWEEN p_from_date AND p_to_date;
    RETURN v_count;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END;

  PROCEDURE schedule_appointment(p_patient_id IN NUMBER,
                                 p_doctor_id  IN NUMBER,
                                 p_appt_date  IN DATE,
                                 p_status     IN VARCHAR2,
                                 p_amount     IN NUMBER) IS
    v_appt_id NUMBER;
    v_pay_status VARCHAR2(20);
  BEGIN
    INSERT INTO Appointments (Patient_ID, Doctor_ID, Appt_Date, Status)
    VALUES (p_patient_id, p_doctor_id, p_appt_date, NVL(p_status,'Scheduled'))
    RETURNING Appt_ID INTO v_appt_id;

    v_pay_status := CASE NVL(p_status,'Scheduled')
                      WHEN 'Cancelled' THEN 'Cancelled'
                      ELSE 'Pending'
                    END;

    INSERT INTO Billing (Appt_ID, Patient_ID, Amount, Payment_Status, Bill_Date)
    VALUES (v_appt_id, p_patient_id, NVL(p_amount,1000), v_pay_status, p_appt_date);
  END;

  PROCEDURE get_patient_history(p_patient_id IN NUMBER,
                                p_from_date  IN DATE,
                                p_to_date    IN DATE,
                                p_history_out OUT t_medrec_tab) IS
  BEGIN
    SELECT patient_id, doctor_id, diagnosis, prescription, record_date
    BULK COLLECT INTO p_history_out
    FROM Medical_Records
    WHERE Patient_ID = p_patient_id
      AND Record_Date BETWEEN p_from_date AND p_to_date
    ORDER BY Record_Date;
  END;

  PROCEDURE bulk_add_med_records(p_records IN t_medrec_tab) IS
  BEGIN
    IF p_records IS NULL OR p_records.COUNT = 0 THEN
      RETURN;
    END IF;

    FORALL i IN INDICES OF p_records
      INSERT INTO Medical_Records (Patient_ID, Doctor_ID, Diagnosis, Prescription, Record_Date)
      VALUES (p_records(i).patient_id,
              p_records(i).doctor_id,
              p_records(i).diagnosis,
              p_records(i).prescription,
              p_records(i).record_date);
  END;

END healthcare_ops;
/
