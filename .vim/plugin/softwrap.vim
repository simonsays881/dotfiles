"last modified 2016-07-22

func! s:removeHardbreaksWithinGrafs()
  "remove trailing spaces
  sil! %s/\s\+$//

  "double every blank line
  sil %s/^$/\r/

  "at every non-blank line, reformat up to paragraph end
  g/./ norm vipJ

  "remove any blank lines at bof
  sil 1 g/^$/ .,/./j

  "remove any blank lines at eof
  sil $ g/^$/ ?.?,.j

  "collapse consecutive blanks lines to one
  v/./ .,/./-1 j
endfunc

com! Softwrap call s:removeHardbreaksWithinGrafs()
