" last modified 2016-12-14

"au bufwritepre * call Trimspace()

com! Trimspace call s:trimspace()

func! s:trimspace()
  " don't do in diff-mode, as it could corrupt file-writes
  if &diff
    return
  endif

  norm mx

  " trim trailing space unless both tw and wm are set
  "if !(&tw && &wm)
    sil! %s/\s\+$//
  "endif

  " from top, if blank line found, collapse it with all its
  " subsequent consecutive blank lines

  sil 1 g/^$/ .,/./j

  sil $ g/^$/ ?.?,.j

  sil v/./,/./-j

  sil! norm `x
endfunc

