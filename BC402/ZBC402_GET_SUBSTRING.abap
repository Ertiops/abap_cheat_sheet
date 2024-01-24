REPORT ZBC402_GET_SUBSTRING.

DATA: gv_text TYPE string,
      gv_off TYPE i,
      gv_len type i.

gv_text = 'ASDLPASFIND;ladgml;'.

find 'FIND' in gv_text match offset gv_off match length gv_len.
if sy-subrc = 0.
* writes query substring if found in source string
  write gv_text+gv_off(gv_len) .
endif.