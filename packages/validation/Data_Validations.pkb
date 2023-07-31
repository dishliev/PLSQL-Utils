CREATE OR REPLACE PACKAGE BODY Data_Validations AS

  FUNCTION Is_Email(email IN VARCHAR2) RETURN BOOLEAN IS
    email_pattern CONSTANT VARCHAR2(100) := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
  BEGIN
    RETURN REGEXP_LIKE(email, email_pattern);
  END;
  
END Data_Validations;
/
