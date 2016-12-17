" last modified 2016-12-14

au bufread,bufnewfile *.tex,*.sty call s:texReadOptions()

au bufwritepre *.tex sil! call s:texWritePreOptions()

au bufwritepost *.tex sil! call s:texWritePostOptions()

func! s:texReadOptions()
  setl com=:%
  "setl flp=^\\s*\\\\item\\S*\\s\\+
  "setl fo+=n
  setl def=^\\s*\\\\\\(new\\\|def\\)[^\\\\]*
  setl sua+=.tex
  setl path=.,$HOME/texmf/tex
  setl tw=65
  ru syntax/plaintex.vim

  syn clear initexComment
  syn match initexComment '\%([\\`"-.{]\)\@<!\%(\\\\\)*\zs%.*$'

  if !exists("g:plaintex_no_math")
    syn clear plaintexMath
    syn region  plaintexMath                  matchgroup=plaintexMath
          \ contains=@plaintexMath,@NoSpell
          \ start='\%(`\)\@<!\$' skip='\\\\\|\\\$' end='\$'
    syn region  plaintexMath                  matchgroup=plaintexMath
          \ contains=@plaintexMath,@NoSpell keepend
          \ start='\$\$' skip='\\\\\|\\\$' end='\$\$'
  endif
endfunc

func! s:texWritePreOptions()
  1,5 g/\<texrc\>/ let l:smartQuoteP = 1
  g/^%\%(html\|xetex\)\s*$/ let l:smartQuoteP = 1

  if !exists('l:smartQuoteP')
    return
  endif

  norm my

  sil! call s:texSmartQuotesEtc()

  norm `y
endfunc

func! s:texSmartQuotesEtc()
  %s:\s\+$::

  %s:Þ:ÞtzpThornTzp:g

  g:\\\(evalh\|p\|q\){$: .,/^}$/ s:^:ÞtzpPreformattedTzp:

  g:\\font: s:^:ÞtzpPreformattedTzp:

  %s:\\char":\\charÞtzpDoubleQuote:g

  g:{'\+}: s:^:ÞtzpPreformattedTzp:

  g:"|: s:^:ÞtzpPreformattedTzp:

  g:href=": s:^:ÞtzpPreformattedTzp:

  g:\\\(advance\|do\|vrule\): s:^:ÞtzpPreformattedTzp:

  v:^ÞtzpPreformattedTzp: call SmartQuotesEtc()

  %s:^\(ÞtzpPreformattedTzp\)\+::
  %s:ÞtzpThornTzp:Þ:g
endfunc

com! -range SmartQuotes sil! <line1>,<line2>call SmartQuotesEtc()

func! SmartQuotesEtc()
  "opening doublequote becomes u+201c

  s:\(^\|\s\|(\|\[\)":\1“:g

  "opening singlequote becomes u+2018

  s:\(^\|\s\|(\|\[\)':\1‘:g

  "quote after opening quote is deemed opening

  s:\(‘\)":\1“:g

  s:\(“\)':\1‘:g

  "closing doublequote becomes u+201d

  s:`\@<!"`\@!:”:g

  "closing singlequote becomes u+2019

  s:':’:g

  s:ÞtzpDoubleQuote:":g

  "--- preceded by {bol, space, :} and
  "followed by {space, comma, closing quote, eol}
  "becomes u+2015

  "s=\(^\|\s\|:\)---\([ ,’”]\|$\)=\1―\2=g

  "-- preceded by {bol, space, :} and
  "followed by {space, comma, closing quote, semicolon, eol}
  "becomes em dash (u+2014)

  s=\(^\|\s\|:\)--\([ ,’”;]\|$\)=\1—\2=g

  " -- followed by closing quote becomes em dash

  " s:--\([’”]\):—\1:g

  " - directly between a {digit, quote} and a digit becomes en dash (u+2013)

  s:\(\d\|[’”]\)-\(\d\):\1–\2:g

  " en dashes flanking a number revert to hyphens

  s:–\([0-9.]\+\)[-–]:-\1-:g

  "hyphen preceded by {bol, space} and
  "followed by opt spaces and then number becomes u+2212

  s:\(^\|\s\)-\(\s*\.\?\d\):\1−\2:g

  "hyphen following + becomes u+2212

  s:+-:+−:g
endfunc

func! s:texWritePostOptions()
  g/^%\s*html\s*$/ let l:toHtmlP = 1

  if exists('l:toHtmlP')
    !tex2page.lisp %
  endif
endfunc
