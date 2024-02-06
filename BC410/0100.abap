PROCESS BEFORE OUTPUT.
  MODULE move_to_dynp.
  MODULE status_0100.
  MODULE modify_screen.
  MODULE fill_dynnr.

CALL SUBSCREEN gv_sub INCLUDING sy-cprog gv_dynnr.

PROCESS AFTER INPUT.
  MODULE exit AT EXIT-COMMAND.
   CALL SUBSCREEN gv_sub.
    CHAIN.
      FIELD: sdyn_conn-carrid,
             sdyn_conn-connid,
             sdyn_conn-fldate.
      MODULE check_sflight ON CHAIN-REQUEST.
    ENDCHAIN.
    CHAIN.
      FIELD: sdyn_conn-seatsmax,
             sdyn_conn-planetype.
      MODULE check_planetype ON CHAIN-REQUEST.
    ENDCHAIN.


  MODULE user_command_0100.
