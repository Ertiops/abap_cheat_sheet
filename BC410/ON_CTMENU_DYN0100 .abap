FORM on_ctmenu_dyn0100 USING p_menu TYPE REF TO cl_ctmenu.
    CALL METHOD cl_ctmenu=>load_gui_status
    EXPORTING
      program = sy-cprog
      status  = 'dyn0100'
      menu    = p_menu.
ENDFORM.