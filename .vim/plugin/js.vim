" last modified 2016-10-30

au bufread,bufnewfile *.js,*.json call s:jsOptions()

func! s:jsOptions()
  "setl cc=80

  nno <buffer> j gj
  nno <buffer> k gk

  ru indent/javascript.vim

  ru syntax/javascript.vim

  call rainbow#hook()

  if expand('%:e') == 'json'
    syn region label oneline start='[\\]\@<!"' skip='\\[\\"]' end='"\%(\s*:\)\@='
  endif
endfunc
