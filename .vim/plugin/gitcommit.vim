" last modified 2016-07-22

au bufread,bufnewfile */.git/{COMMIT_EDITMSG,MERGE_MSG} call s:gitcommitOptions()

func! s:gitcommitOptions()
  ru syntax/gitcommit.vim
endfunc
