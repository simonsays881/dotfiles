" last modified 2016-07-26

au bufread,bufnewfile *.y call s:yaccOptions()

func! s:yaccOptions()
  "setl cin
  "setl cino+=:0

  ru syntax/yacc.vim
  ru indent/yacc.vim
  call rainbow#hook()
endfunc
