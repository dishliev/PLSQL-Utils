CREATE OR REPLACE PACKAGE BODY Logger AS

  PROCEDURE Log_To_File(
    p_level IN NUMBER,
    p_module IN VARCHAR2,
    p_message IN VARCHAR2
  ) IS
    v_file UTL_FILE.file_type;
    v_log_file_name VARCHAR2(100);
    v_log_date VARCHAR2(8);
    v_log_format VARCHAR2(4000);
  BEGIN
    v_log_date := TO_CHAR(SYSDATE, 'YYYYMMDD');
    v_log_file_name := v_log_date || '_log.txt';

    v_log_format := '[' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') || '] ';

    CASE p_level
      WHEN INFO THEN
        v_log_format := v_log_format || '[INFO]';
      WHEN DEBUG THEN
        v_log_format := v_log_format || '[DEBUG]';
      WHEN WARNING THEN
        v_log_format := v_log_format || '[WARNING]';
      WHEN ERROR THEN
        v_log_format := v_log_format || '[ERROR]';
      ELSE
        v_log_format := v_log_format || '[UNKNOWN]';
    END CASE;
    
    v_log_format := v_log_format || ' ';

    v_log_format := v_log_format || '[' || p_module || '] [' || p_message || ']';

    v_file := UTL_FILE.fopen('LOGS', v_log_file_name, 'a', 32767);
    UTL_FILE.put_line(v_file, v_log_format);
    UTL_FILE.fclose(v_file);
  EXCEPTION
    WHEN OTHERS THEN
      IF UTL_FILE.is_open(v_file) THEN
        UTL_FILE.fclose(v_file);
      END IF;
      RAISE;
  END Log_To_File;
END Logger;
