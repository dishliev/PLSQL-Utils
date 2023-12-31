CREATE OR REPLACE PACKAGE BODY Data_Validations AS

  FUNCTION Is_Email(p_email IN VARCHAR2) RETURN BOOLEAN IS
    email_pattern CONSTANT VARCHAR2(100) := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';
  BEGIN
    RETURN REGEXP_LIKE(p_email, email_pattern);
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
  
  FUNCTION Is_Alpha(p_string VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    RETURN REGEXP_LIKE(p_string, '^[A-Za-z]+$');
  END Is_Alpha;
  
  FUNCTION Is_Numeric(p_string VARCHAR2) RETURN BOOLEAN IS
  v_num NUMBER;
  BEGIN
    BEGIN
      v_num := TO_NUMBER(p_string);
      RETURN TRUE;
    EXCEPTION
      WHEN VALUE_ERROR THEN
        RETURN FALSE;
    END;
  END Is_Numeric;
  
  FUNCTION Is_Country_Code(p_code VARCHAR2) RETURN BOOLEAN IS
    v_country_code_list CONSTANT VARCHAR2(1000) :=
      ',AD,AE,AF,AG,AI,AL,AM,AO,AQ,AR,AS,AT,AU,AW,AX,AZ,BA,BB,BD,BE,BF,BG,BH,BI,BJ,BL,BM,BN,BO,BQ,BR,' ||
      'BS,BT,BV,BW,BY,BZ,CA,CC,CD,CF,CG,CH,CI,CK,CL,CM,CN,CO,CR,CU,CV,CW,CX,CY,CZ,DE,DJ,DK,DM,DO,DZ,' ||
      'EC,EE,EG,EH,ER,ES,ET,FI,FJ,FK,FM,FO,FR,GA,GB,GD,GE,GF,GG,GH,GI,GL,GM,GN,GP,GQ,GR,GS,GT,GU,GW,' ||
      'GY,HK,HM,HN,HR,HT,HU,ID,IE,IL,IM,IN,IO,IQ,IR,IS,IT,JE,JM,JO,JP,KE,KG,KH,KI,KM,KN,KP,KR,KW,KY,' ||
      'KZ,LA,LB,LC,LI,LK,LR,LS,LT,LU,LV,LY,MA,MC,MD,ME,MF,MG,MH,MK,ML,MM,MN,MO,MP,MQ,MR,MS,MT,MU,MV,' ||
      'MW,MX,MY,MZ,NA,NC,NE,NF,NG,NI,NL,NO,NP,NR,NU,NZ,OM,PA,PE,PF,PG,PH,PK,PL,PM,PN,PR,PS,PT,PW,PY,' ||
      'QA,RE,RO,RS,RU,RW,SA,SB,SC,SD,SE,SG,SH,SI,SJ,SK,SL,SM,SN,SO,SR,SS,ST,SV,SX,SY,SZ,TC,TD,TF,TG,' ||
      'TH,TJ,TK,TL,TM,TN,TO,TR,TT,TV,TW,TZ,UA,UG,UM,US,UY,UZ,VA,VC,VE,VG,VI,VN,VU,WF,WS,YE,YT,ZA,ZM,ZW';
  BEGIN
    IF LENGTH(p_code) <> 2 THEN
      RETURN FALSE;
    END IF;
  
    RETURN INSTR(v_country_code_list, ',' || UPPER(p_code) || ',') > 0;
  END Is_Country_Code;
  
  FUNCTION Is_Currency_Code(p_code VARCHAR2) RETURN BOOLEAN IS
    v_currency_codes CONSTANT VARCHAR2(2000) :=
      ',AED,AFN,ALL,AMD,ANG,AOA,ARS,AUD,AWG,AZN,BAM,BBD,BDT,BGN,BHD,BIF,BMD,BND,BOB,BOV,BRL,BSD,BTN,BWP,' ||
      'BYN,BYR,BZD,CAD,CDF,CHE,CHF,CHW,CLF,CLP,CNY,COP,COU,CRC,CUC,CUP,CVE,CZK,DJF,DKK,DOP,DZD,EGP,ERN,' ||
      'ETB,EUR,FJD,FKP,GBP,GEL,GHS,GIP,GMD,GNF,GTQ,GYD,HKD,HNL,HRK,HTG,HUF,IDR,ILS,INR,IQD,IRR,ISK,JMD,' ||
      'JOD,JPY,KES,KGS,KHR,KMF,KPW,KRW,KWD,KYD,KZT,LAK,LBP,LKR,LRD,LSL,LYD,MAD,MDL,MGA,MKD,MMK,MNT,MOP,' ||
      'MRU,MUR,MVR,MWK,MXN,MXV,MYR,MZN,NAD,NGN,NIO,NOK,NPR,NZD,OMR,PAB,PEN,PGK,PHP,PKR,PLN,PYG,QAR,RON,' ||
      'RSD,RUB,RWF,SAR,SBD,SCR,SDG,SEK,SGD,SHP,SLL,SOS,SRD,SSP,STD,SVC,SYP,SZL,THB,TJS,TMT,TND,TOP,TRY,' ||
      'TTD,TWD,TZS,UAH,UGX,USD,USN,USS,UYI,UYU,UZS,VEF,VND,VUV,WST,XAF,XAG,XAU,XBA,XBB,XBC,XBD,XCD,XDR,' ||
      'XOF,XPD,XPF,XPT,XSU,XTS,XUA,XXX,YER,ZAR,ZMW,ZWL';
  BEGIN
    RETURN LENGTH(p_code) = 3 AND INSTR(v_currency_codes, ',' || UPPER(p_code) || ',') > 0;
  END Is_Currency_Code;
  
  FUNCTION Is_UUID(p_uuid IN VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    RETURN REGEXP_LIKE(p_uuid, '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
  END;
  
  FUNCTION Is_JSON(p_json_string IN VARCHAR2) RETURN BOOLEAN IS
    v_json JSON_OBJECT_T;
  BEGIN
    v_json := JSON_OBJECT_T.PARSE(p_json_string);
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END;
  
  FUNCTION Is_XML(p_xml_string IN CLOB) RETURN BOOLEAN IS
    v_xml XMLType;
  BEGIN
    v_xml := XMLType(p_xml_string);
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END;
  
  FUNCTION Is_Hex_Color_Code(p_color_code IN VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    RETURN REGEXP_LIKE(p_color_code, '^#([0-9A-Fa-f]{3}){1,2}$');
  END;
  
  FUNCTION Is_FileExtension(p_file_name VARCHAR2, p_extension VARCHAR2) RETURN BOOLEAN IS
    v_file_ext VARCHAR2(100);
  BEGIN
    v_file_ext := SUBSTR(p_file_name, INSTR(p_file_name, '.', -1) + 1);
    RETURN (UPPER(v_file_ext) = UPPER(p_extension));
  END Is_FileExtension;
  
  FUNCTION Is_Password_Strong(p_password VARCHAR2) RETURN BOOLEAN IS
    v_min_length CONSTANT NUMBER := 8;
    v_has_uppercase BOOLEAN := FALSE;
    v_has_lowercase BOOLEAN := FALSE;
    v_has_digit BOOLEAN := FALSE;
    v_has_special_char BOOLEAN := FALSE;
    v_char CHAR;
  BEGIN
    IF LENGTH(p_password) < v_min_length THEN
      RETURN FALSE;
    END IF;

    FOR i IN 1..LENGTH(p_password) LOOP
      v_char := SUBSTR(p_password, i, 1);
      IF ASCII(v_char) BETWEEN 65 AND 90 THEN
        v_has_uppercase := TRUE;
      ELSIF ASCII(v_char) BETWEEN 97 AND 122 THEN
        v_has_lowercase := TRUE;
      ELSIF ASCII(v_char) BETWEEN 48 AND 57 THEN
        v_has_digit := TRUE;
      ELSE
        v_has_special_char := TRUE;
      END IF;
    END LOOP;

    RETURN (v_has_uppercase AND v_has_lowercase AND v_has_digit AND v_has_special_char);
  END Is_Password_Strong;

  FUNCTION Is_Valid_MIME_Type(p_string IN VARCHAR2) RETURN BOOLEAN IS
    v_valid_mime_types CONSTANT VARCHAR2(4000) := ',text/plain,text/html,application/pdf,image/jpeg,application/json,video/mp4,audio/mpeg,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,';
  BEGIN
    RETURN INSTR(v_valid_mime_types, ',' || LOWER(p_string) || ',') > 0;
  END Is_Valid_MIME_Type;
  
  FUNCTION Is_Empty_CLOB(p_clob CLOB) RETURN BOOLEAN IS
    v_length NUMBER;
  BEGIN
    v_length := DBMS_LOB.GETLENGTH(p_clob);
    RETURN (v_length = 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END Is_Empty_CLOB;
  
  FUNCTION Is_CLOB_Contains(p_clob CLOB, p_substring VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    RETURN (DBMS_LOB.INSTR(p_clob, p_substring) > 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END Is_CLOB_Contains;
  
  FUNCTION Is_CLOB_NotContains(p_clob CLOB, p_substring VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    RETURN (DBMS_LOB.INSTR(p_clob, p_substring) = 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END Is_CLOB_NotContains;
  
END Data_Validations;
/
