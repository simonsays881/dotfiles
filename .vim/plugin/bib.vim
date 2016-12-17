" last modified 2016-11-21

au bufread,bufnewfile *.bib call s:bibOptions()

func! s:bibOptions()
  setl cin

  ru syntax/bib.vim
  call rainbow#hook()
endfunc
