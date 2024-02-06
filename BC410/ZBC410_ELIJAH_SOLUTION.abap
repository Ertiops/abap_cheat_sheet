*&---------------------------------------------------------------------*
*& Module Pool      ZBC410_ELIJAH_SOLUTION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE zbc410_elijah_solution_top.
INCLUDE zbc410_elijah_solution_cls.

INCLUDE zbc410_elijah_solution_pai.
INCLUDE zbc410_elijah_solution_pbo.

INCLUDE z410_elijah_solution_form.
INCLUDE zbc410_elijah_solution100_form.

LOAD-OF-PROGRAM.

CALL METHOD lcl_screen_logic=>get_parameter_ids. " Получение ID входных параметров из SAP-памяти.
CALL METHOD lcl_screen_logic=>get_sflight. " Получение строки sflight по входным параметрам.
