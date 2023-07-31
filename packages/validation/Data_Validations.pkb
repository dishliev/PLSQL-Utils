CREATE OR REPLACE PACKAGE BODY Data_Validations AS

  FUNCTION Is_Email(email IN VARCHAR2) RETURN BOOLEAN IS
    email_pattern CONSTANT VARCHAR2(100) := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
  BEGIN
    RETURN REGEXP_LIKE(email, email_pattern);
  END;
  
  FUNCTION Is_AlphaNumeric(p_input_string IN VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    RETURN REGEXP_LIKE(p_input_string, '^[[:alnum:]]+$');
  END Is_AlphaNumeric;
  
  FUNCTION Is_Date(p_date IN VARCHAR2, p_date_format IN VARCHAR2) RETURN BOOLEAN
  IS
    v_date DATE;
  BEGIN
    SELECT TO_DATE(p_date, p_date_format) INTO v_date FROM dual;
    RETURN TRUE;
  EXCEPTION WHEN OTHERS THEN RETURN FALSE;
  END Is_Date;
  
END Data_Validations;
/
