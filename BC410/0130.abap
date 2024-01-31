PROCESS BEFORE OUTPUT.
* MODULE STATUS_0130.
  MODULE get_sbook.
  LOOP AT gt_sdyn_book INTO gs_sdyn_book WITH CONTROL
    my_table_control.
    MODULE trans_to_tc.
    MODULE modify_tc_line.
  ENDLOOP.

PROCESS AFTER INPUT.
* MODULE USER_COMMAND_0130.
  LOOP AT gt_sdyn_book.
    FIELD sdyn_book-mark
    MODULE trans_to_tc ON REQUEST.
  ENDLOOP.
  MODULE user_command_0130.