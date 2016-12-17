"last modified 2016-07-14

func! EnsurePlugin(repo)
  let l:pkgname = substitute(a:repo, '^.*/\(\S\+\)$', '\1', '')
  let l:vimdir = split(&rtp, ',')[0]
  let l:pkgdir = l:vimdir . '/pack/' . l:pkgname . '/start'
  if finddir(l:pkgdir) == ''
    sil exec '!mkdir -p' l:pkgdir
    sil exec '!cd' l:pkgdir '; git clone' a:repo
  endif
endfunc
