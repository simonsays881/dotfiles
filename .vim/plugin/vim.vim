" last modified 2016-10-23

au bufread,bufnewfile *.vim,*vimrc call s:vimOptions()

func! s:vimOptions()
  let &l:pa = &rtp

  ru indent/vim.vim

  ru syntax/vim.vim
endfunc

com! Vimf e ~/.vim/plugin/js.vim
