" last modified 2016-07-04

au bufread,bufnewfile *.arr call s:arrOptions()

func! s:arrOptions()
  setl isk+=-

"  syn region comment oneline start='|\@<!#|\@!' end='$'
"  syn region comment start='#|' end='|#'
"  syn region string oneline start='[\\]\@<!"' skip='\\[\\"]' end='"'

  ru indent/pyret.vim

  ru syntax/pyret.vim
  call rainbow#hook()
endfunc
