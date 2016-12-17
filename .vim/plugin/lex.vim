" last modified 2016-07-23

au bufread,bufnewfile *.l call s:lexOptions()

func! s:lexOptions()
  setl cin
  "setl cino+=:0

  ru syntax/lex.vim
  call rainbow#hook()
endfunc
