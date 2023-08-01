CREATE OR REPLACE PACKAGE Logger AS

  INFO     CONSTANT NUMBER := 1;
  DEBUG    CONSTANT NUMBER := 2;
  WARNING  CONSTANT NUMBER := 3;
  ERROR    CONSTANT NUMBER := 4;

  PROCEDURE Log_To_File(
    p_level IN NUMBER,
    p_module IN VARCHAR2,
    p_message IN VARCHAR2
  );

END Logger;