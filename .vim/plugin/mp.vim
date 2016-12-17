" last modified 2016-11-26

au bufread,bufnewfile *.mp call s:mpReadOptions()

func! s:mpReadOptions()
  run syntax/mp.vim
endfunc
