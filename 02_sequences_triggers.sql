-- Simple trigger: update Billing when Appointment Status changes
CREATE OR REPLACE TRIGGER trg_appt_status_to_billing
AFTER UPDATE OF Status ON Appointments
FOR EACH ROW
DECLARE
  v_payment_status VARCHAR2(20);
BEGIN
  IF :NEW.Status = 'Completed' THEN
    v_payment_status := 'Pending';
  ELSIF :NEW.Status = 'Cancelled' THEN
    v_payment_status := 'Cancelled';
  ELSE
    v_payment_status := 'Pending';
  END IF;

  UPDATE Billing
     SET Payment_Status = v_payment_status,
         Bill_Date      = NVL(Bill_Date, SYSDATE)
   WHERE Appt_ID = :NEW.Appt_ID;
END;
/
