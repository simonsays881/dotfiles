" last modified 2016-07-31

au bufread,bufnewfile *.[ch] call s:cOptions()

func! s:cOptions()
  setl cin
  "setl cino+=:0

  ru syntax/c.vim
  call rainbow#hook()
endfunc
