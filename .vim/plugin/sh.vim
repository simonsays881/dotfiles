" last modified 2016-10-23

au bufread,bufnewfile *.sh call s:shOptions()

func! s:shOptions()
  ru indent/sh.vim

  let b:is_bash = 1

  ru syntax/sh.vim

endfunc

au bufread,bufnewfile .aliases*,.bash*,.env*,**/bin/*,*t2page,*t2page_*
      \ do bufread binNot/pretend.sh

"au bufread,bufnewfile **/bin/* do bufread binNot/pretend.sh
