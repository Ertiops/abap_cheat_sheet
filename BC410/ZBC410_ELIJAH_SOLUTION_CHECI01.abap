*----------------------------------------------------------------------*
***INCLUDE ZBC410_ELIJAH_SOLUTION_CHECI01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  CHECK_SFLIGHT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_sflight INPUT.
  SELECT SINGLE * FROM sflight
    INTO gs_sflight
    WHERE carrid = sdyn_conn-carrid
    AND connid = sdyn_conn-connid
    AND fldate = sdyn_conn-fldate.
    CHECK sy-subrc <> 0.
    CLEAR gs_sflight.
    MESSAGE i007(zbc410_elijah).
ENDMODULE.


MODULE user_command_0100 INPUT.
  CASE ok_code.
    WHEN 'FC1' OR 'FC2' OR 'FC3'.
      my_tabstrip-activetab = ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'TIME'.
      CALL SCREEN 150
        STARTING AT 10 10
        ENDING AT 50 20.
    WHEN 'CANCEL'.
      CLEAR sdyn_conn.
      SET PARAMETER ID:
        'CAR' FIELD sdyn_conn-carrid,
        'CON' FIELD sdyn_conn-connid,
        'DAY' FIELD sdyn_conn-fldate.
      LEAVE TO SCREEN 100.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'SAVE'.
      MOVE-CORRESPONDING sdyn_conn TO gs_sflight.
      UPDATE sflight FROM gs_sflight.
      IF sy-subrc <> 0.
        MESSAGE a010(zbc410_elijah).
      ENDIF.
      MESSAGE a011(zbc410_elijah).
  ENDCASE.
ENDMODULE.

MODULE user_command_0150 INPUT.
  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'OKAY'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.

MODULE exit INPUT.
  CASE ok_code.
    WHEN 'CANCEL'.
      CLEAR sdyn_conn.
      SET PARAMETER ID:
        'CAR' FIELD sdyn_conn-carrid,
        'CON' FIELD sdyn_conn-connid,
        'DAY' FIELD sdyn_conn-fldate.
      LEAVE TO SCREEN 100.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE check_planetype INPUT.
  IF sdyn_conn-planetype IS INITIAL.
    MESSAGE e008(zbc410_elijah).
  ENDIF.

  SELECT SINGLE seatsmax FROM saplane
    INTO sdyn_conn-seatsmax WHERE planetype = sdyn_conn-planetype.

  IF sdyn_conn-seatsocc > sdyn_conn-seatsmax.
    MESSAGE e009(zbc410_elijah).
  ENDIF.

ENDMODULE.

MODULE trans_from_tc INPUT.
  MOVE sdyn_book-mark TO gs_sdyn_book-mark.
  MODIFY gt_sdyn_book INDEX my_table_control-current_line
  FROM gs_sdyn_book TRANSPORTING mark.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0130  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0130 INPUT.
  CASE ok_code.
    WHEN 'SELE'.
      LOOP AT gt_sdyn_book INTO gs_sdyn_book
        WHERE mark = space.
        gs_sdyn_book-mark = 'X'.
        MODIFY gt_sdyn_book FROM gs_sdyn_book TRANSPORTING mark.
      ENDLOOP.
    WHEN 'DSELE'.
      LOOP AT gt_sdyn_book INTO gs_sdyn_book
        WHERE mark = 'X'.
        gs_sdyn_book-mark = space.
        MODIFY gt_sdyn_book FROM gs_sdyn_book TRANSPORTING mark.
      ENDLOOP.
    WHEN 'SRTU'.
      READ TABLE my_table_control-cols INTO gs_cols WITH KEY selected = 'X'.
      IF sy-subrc = 0.
        SORT gt_sdyn_book BY (gs_cols-screen-name+10) ASCENDING.
      ENDIF.
    WHEN 'SRTD'.
      READ TABLE my_table_control-cols INTO gs_cols WITH KEY selected = 'X'.
      IF sy-subrc = 0.
        SORT gt_sdyn_book BY (gs_cols-screen-name+10) DESCENDING.
      ENDIF.
  ENDCASE.
ENDMODULE.