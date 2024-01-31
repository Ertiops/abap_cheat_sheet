*&---------------------------------------------------------------------*
*& Include          ZBC410_ELIJAH_SOLUTION00E01
*&---------------------------------------------------------------------*
LOAD-OF-PROGRAM.

GET PARAMETER ID:
  'CAR' FIELD sdyn_conn-carrid,
  'CON' FIELD sdyn_conn-connid,
  'DAY' FIELD sdyn_conn-fldate.

SELECT SINGLE * FROM sflight
  INTO CORRESPONDING FIELDS OF sdyn_conn
  WHERE carrid = sdyn_conn-carrid AND
        connid = sdyn_conn-connid AND
        fldate = sdyn_conn-fldate.