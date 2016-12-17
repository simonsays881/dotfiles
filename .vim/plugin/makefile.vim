" last modified 2016-07-09

au bufread,bufnewfile *[Mm]akefile call s:makefileOptions()

func! s:makefileOptions()
  setl noet
  setl sw=0

  ru syntax/make.vim
  syn match errormsg '^ \+'
endfunc
