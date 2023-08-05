CREATE OR REPLACE PACKAGE Data_Validations AS

  FUNCTION Is_Email(p_email IN VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_AlphaNumeric(p_input_string IN VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_Date(p_date IN VARCHAR2, p_date_format IN VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_Alpha(p_string VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_Numeric(p_string VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_Country_Code(p_code VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_Currency_Code(p_code VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_UUID(p_uuid IN VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_JSON(p_json_string IN VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_XML(p_xml_string IN CLOB) RETURN BOOLEAN;
  
  FUNCTION Is_Hex_Color_Code(p_color_code IN VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_FileExtension(p_file_name VARCHAR2, p_extension VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_Password_Strong(p_password VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_Valid_MIME_Type(p_string IN VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_Empty_CLOB(p_clob CLOB) RETURN BOOLEAN;
  
  FUNCTION Is_CLOB_Contains(p_clob CLOB, p_substring VARCHAR2) RETURN BOOLEAN;
  
  FUNCTION Is_CLOB_NotContains(p_clob CLOB, p_substring VARCHAR2) RETURN BOOLEAN;

END Data_Validations;
/
