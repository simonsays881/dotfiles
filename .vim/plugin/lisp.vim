" last modified 2016-11-15

au bufread,bufnewfile *.lisp,*.cl call s:lispOptions()

func! s:lispOptions()
  setl isk+==,+,-,*,>,.,?,/,!
  setl lisp
  setl lw-=if

  setl lw+=block,call-with-input-string/buffered,call-with-lazy-image-port,concatenate,loop

  ru syntax/lisp.vim

  call rainbow#hook()
endfunc

au bufread,bufnewfile troff2page do bufread pretend.lisp
