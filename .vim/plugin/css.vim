" last modified 2016-07-10

au bufread,bufnewfile *.css call s:cssOptions()

func! s:cssOptions()
  ru indent/css.vim
  ru syntax/css.vim
endfunc
