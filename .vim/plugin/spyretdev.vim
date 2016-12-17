"last modified 2016-11-22

au bufread,bufnewfile **/public_html/**.{arr,bnf,js} call s:spyretOptions()

func! s:spyretOptions()

  setl path=.
        \,$PYRETHOME/src/arr/base
        \,$PYRETHOME/src/arr/compiler
        \,$PYRETHOME/src/arr/locker
        \,$PYRETHOME/src/arr/trove
        \,$PYRETHOME/src/js/base
        \,$PYRETHOME/src/js/trove
        \,$PYRETHOME/../code.pyret.org/src
        \,$PYRETHOME/../code.pyret.org/src/storage
        \,$PYRETHOME/../code.pyret.org/src/web/js
        \,$PYRETHOME/../code.pyret.org/src/web/js/google-apis
        \,$PYRETHOME/../code.pyret.org/src/web/js/trove
        \,$PYRETHOME/../code.pyret.org/src/web/arr/trove
        \,$PYRETHOME/tests/pyret/tests

endfunc

au bufread,bufnewfile **/public_html/*.js.* do bufread .js

au bufread,bufnewfile cpo-heroku do bufread binNot/pretend.sh

"au bufwritepre **/ds26gte.github.io/spyret/*.adoc call s:spyretStatusOptions()

func! s:spyretStatusOptions()
  Softwrap
endfunc

au bufwritepre **/Downloads/*.js call s:beautifyJSconsoleLog()

func! s:beautifyJSconsoleLog()
  norm mx
  norm gg=G
  g/"pos":/+1 norm daB
  g/"pos":/d
  norm `x
endfunc

com! Gios e ~/gh/ds26gte.github.io/spyret/wescheme-ops.adoc
com! Py e ~/public_html/pyret-lang/src/js/trove/parse-pyret.js
com! Spy e ~/public_html/code.pyret.org/src/web/js/spyret-parse.js
com! Wesj e ~/public_html/wescheme2012/war-src/js/js-runtime/world/jsworld.js
