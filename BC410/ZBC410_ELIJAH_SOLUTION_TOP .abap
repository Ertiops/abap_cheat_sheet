*&---------------------------------------------------------------------*
*& Include ZBC410_ELIJAH_SOLUTION_TOP               - Module Pool      ZBC410_ELIJAH_SOLUTION
*&---------------------------------------------------------------------*
PROGRAM zbc410_elijah_solution.

TABLES: sdyn_conn,
        saplane,
        sdyn_book.

CONTROLS: my_tabstrip TYPE TABSTRIP,
          my_table_control TYPE TABLEVIEW USING SCREEN '0130'.

CONSTANTS:
          cv_fc1 TYPE c LENGTH 3 VALUE 'FC1',
          cv_fc2 TYPE c LENGTH 3 VALUE 'FC2',
          cv_fc3 TYPE c LENGTH 3 VALUE 'FC3',
          cv_back TYPE C LENGTH 4 VALUE 'BACK',
          cv_save TYPE C LENGTH 4 VALUE 'SAVE',
          cv_time TYPE C LENGTH 4 VALUE 'TIME',
          cv_exit TYPE C LENGTH 4 VALUE 'EXIT',
          cv_okay TYPE C LENGTH 4 VALUE 'OKAY',
          cv_cancel TYPE C LENGTH 6 VALUE 'CANCEL',
          cv_select TYPE C LENGTH 4 VALUE 'SELE',
          cv_deselect TYPE C LENGTH 5 VALUE 'DSELE',
          cv_sortu TYPE C LENGTH 4 VALUE 'SRTU',
          cv_sortd TYPE C LENGTH 4 VALUE 'SRTD'.

DATA:   gv_view  TYPE flag VALUE abap_true,
        gv_maintain_flights TYPE flag,
        gv_maintain_bookings TYPE flag,
        gs_sflight        TYPE sflight,
        gv_dynnr             TYPE sy-dynnr,
        gv_not_cancelled VALUE space,
        gt_sdyn_book TYPE TABLE OF sdyn_book,
        gs_sdyn_book LIKE LINE OF gt_sdyn_book,
        gv_smoker TYPE s_smoker,
        gs_cols LIKE LINE OF my_table_control-cols.
