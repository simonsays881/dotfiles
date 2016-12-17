" last modified 2016-12-12

au bufread,bufnewfile *.rkt,*.scm,*.ss call s:racketOptions()

func! s:racketOptions()
  setl isk+==,+,-,*,>,.,?,/,!
  setl lisp
  setl lw-=if

  setl lw+=call-with-input-file,call-with-output-file,datum->syntax,define-values,fluid-let,
        \let-values,parameterize,with-output-to-port

  let b:is_mzscheme = 1

  ru syntax/scheme.vim

  call rainbow#hook()
endfunc

au bufread,bufnewfile tex2page do bufread pretend.rkt

