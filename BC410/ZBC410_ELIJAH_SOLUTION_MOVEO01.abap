*----------------------------------------------------------------------*
***INCLUDE ZBC410_ELIJAH_SOLUTION_MOVEO01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Module MOVE_TO_DYNP OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE move_to_dynp OUTPUT.
  MOVE-CORRESPONDING gs_sflight TO sdyn_conn.
ENDMODULE.


MODULE clear_ok_code OUTPUT.
  CLEAR ok_code.
ENDMODULE.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS100'.
  CASE 'X'.
    WHEN view.
      SET TITLEBAR 'TITLE_0100' WITH TEXT-vie.
    WHEN maintain_flights.
      SET TITLEBAR 'TITLE_0100' WITH TEXT-fli.
    WHEN maintain_bookings.
      SET TITLEBAR 'TITLE_0100' WITH TEXT-boo.
  ENDCASE.
ENDMODULE.

MODULE status_0150 OUTPUT.
  SET PF-STATUS 'STATUS_150'.
  SET TITLEBAR 'TITLE_0150' WITH TEXT-tim.
  syst-uzeit = sy-uzeit.
ENDMODULE.

MODULE modify_screen OUTPUT.
  IF maintain_flights = 'X'.
    SET PF-STATUS 'STATUS100'.
    LOOP AT SCREEN.
      IF screen-name = 'SDYN_CONN-PLANETYPE'.
        screen-input = 1.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ELSE.
    SET PF-STATUS 'STATUS100' EXCLUDING 'SAVE'.
  ENDIF.
ENDMODULE.

MODULE fill_dynnr OUTPUT.
  CASE my_tabstrip-activetab.
    WHEN 'FC1'.
      dynnr = 110.
    WHEN 'FC2'.
      dynnr = 120.
    WHEN 'FC3'.
      dynnr = 130.
    WHEN others.
      my_tabstrip-activetab = 'FC1'.
      dynnr = 110.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module GET_SPFLI OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE get_spfli OUTPUT.
  ON CHANGE OF gs_sflight-carrid OR gs_sflight-connid.
    SELECT SINGLE * INTO CORRESPONDING FIELDS OF sdyn_conn
    FROM spfli WHERE carrid = gs_sflight-carrid AND connid = gs_sflight-connid.
  ENDON.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module GET_SAPLANE OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE get_saplane OUTPUT.
 ON CHANGE OF gs_sflight-planetype.
   SELECT SINGLE * FROM saplane
     WHERE planetype = gs_sflight-planetype.
 ENDON.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module GET_SBOOK OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE get_sbook OUTPUT.
  ON CHANGE OF gs_sflight-carrid
    OR gs_sflight-connid
    OR gs_sflight-fldate.
    SELECT * FROM sbook INTO CORRESPONDING FIELDS OF TABLE gt_sdyn_book
       WHERE carrid = gs_sflight-carrid
          AND connid = gs_sflight-connid
          AND fldate = gs_sflight-fldate
          AND cancelled = not_cancelled.
    my_table_control-lines = lines( gt_sdyn_book ).
  ENDON.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module TRANS_TO_TC OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE trans_to_tc OUTPUT.
  MOVE gs_sdyn_book TO sdyn_book.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module MODIFY_TC_LINE OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE modify_tc_line OUTPUT.
  CHECK gs_sdyn_book-smoker = 'X' AND smoker = 'X'.
  LOOP AT SCREEN.
    screen-intensified = 1.
    MODIFY SCREEN.
  ENDLOOP.
ENDMODULE.