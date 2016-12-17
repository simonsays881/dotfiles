" last modified 2016-07-18

au bufread,bufnewfile *.html call s:htmlOptions()

func! s:htmlOptions()
  ru syntax/html.vim
endfunc
