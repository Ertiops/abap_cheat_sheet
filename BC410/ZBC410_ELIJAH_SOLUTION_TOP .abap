*&---------------------------------------------------------------------*
*& Include ZBC410_ELIJAH_SOLUTION_TOP               - Module Pool      ZBC410_ELIJAH_SOLUTION
*&---------------------------------------------------------------------*
PROGRAM zbc410_elijah_solution.

TABLES: sdyn_conn,
        saplane,
        sdyn_book.

CONTROLS: my_tabstrip TYPE TABSTRIP,
          my_table_control TYPE TABLEVIEW USING SCREEN '0130'.

DATA: ok_code           LIKE sy-ucomm,
      view              VALUE 'X',
      maintain_flights,
      maintain_bookings,
      gs_sflight        TYPE sflight,
      dynnr             TYPE sy-dynnr,
      not_cancelled VALUE space,
      gt_sdyn_book TYPE TABLE OF sdyn_book,
      gs_sdyn_book LIKE LINE OF gt_sdyn_book,
      smoker TYPE c LENGTH 1,
      gs_cols LIKE LINE OF my_table_control-cols.