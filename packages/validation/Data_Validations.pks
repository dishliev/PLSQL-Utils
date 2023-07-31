CREATE OR REPLACE PACKAGE Data_Validations AS

  FUNCTION Is_Email(email IN VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_AlphaNumeric(p_input_string IN VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_Date(p_date IN VARCHAR2, p_date_format IN VARCHAR2) RETURN BOOLEAN;

END Data_Validations;
/
