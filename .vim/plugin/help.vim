" last modified 2016-07-11

au filetype help call s:pagingOptions()

au bufenter **/backup/*.tmp call s:pagingOptions()

"func! s:helpOptions()
"  exec "norm \<c-w>T"
"endfunc

func! s:pagingOptions()
  nno <buffer> <space> <c-f>
  nno <buffer> b <c-b>
  nno <buffer> p <c-b>

  ru syntax/help.vim
  hi! link helpcommand statement
  hi! link helpexample statement
endfunc
