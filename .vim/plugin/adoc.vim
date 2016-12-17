" last modified 2016-12-05

au bufread,bufnewfile *.adoc,*.asciidoc call s:adocOptions()

func! s:adocOptions()

  "setl fde=Asciidocfoldexpr()
  "setl fdm=expr
  "setl cpt+=k
  setl flp=^\\s*\\%(\\d\\+\\.\\\|-\\\|\\*\\+\\\|[UNCOGTIMEWARP]\\+:\\)\\s\\+
  setl fo+=n
  setl inf
  setl tw=65

  ru syntax/asciidoc.vim

  " default asciidocQuotedEmphasizedItalic is unremarkable
  hi! link asciidocQuotedEmphasizedItalic type

  if hlexists('asciidocAdmonition')
    " default syntax file is too liberal in identifying admonitions
    syn clear asciidocAdmonition
    syn match asciidocAdmonition '^\%(CAUTION\|IMPORTANT\|NOTE\|TIP\|WARNING\):\ze\s'
  endif

  if hlexists('asciidocOneLineTitle')
    " default syntax file doesn't recognize header of depth 6
    syn clear asciidocOneLineTitle
    syn match asciidocOneLineTitle /^=\{1,6}\s\+\S.*$/ contains=asciidocQuoted.*,asciidocMacroAttributes,asciidocAttributeRef,asciidocEntityRef,asciidocEmail,asciidocURL,asciidocBackslash
  endif

  if &l:fo =~ 'w'
    return
  endif

  au bufwritepre <buffer> sil! call s:adocWriteOptions()
endfunc

func! Asciidocfoldexpr()
  if match(getline(v:lnum), "^=") >= 0
    return ">1"
  else
    return "="
  endif
endfunc

func! s:adocWriteOptions()
  if &diff
    return
  endif

  norm my

  %s:Þ:&tzpThornTzp:g

  %s/\s\+$//
  1 g/^$/ .,/./j
  $ g/^$/ ?.?,.j
  v/./ .,/./-1 j

  %s:^----$:ÞtzpListingTzp&:
  call Toggle01(0)
  g:^ÞtzpListingTzp: s:^ÞtzpListingTzp:\=submatch(0) . Toggle01():
  g:^ÞtzpListingTzp0: .,/^ÞtzpListingTzp1/ s:^:ÞtzpPreformattedTzp:
  %s:^\(ÞtzpPreformattedTzp\)ÞtzpListingTzp[01]:\1:

  %s/^\s*\%(\d\+\.\|-\|\*\+\|[ACEGIM-PRTUW]\+:\)\s\+\S/ÞtzpItemStartTzp\0/

  g:^ÞtzpItemStartTzp: .,'} s:^:ÞtzpItemBodyTzp:

  "why this? because of bulleted items with no parsep
  %s:^\(ÞtzpItemBodyTzp\)\{2,}:\1:

  %s:^\(ÞtzpItemBodyTzp\)ÞtzpItemStartTzp:\1:

  "line containing just space followed by +
  "%s:^\( \|\s\)\++$:  +:

  %s:^\(\s\+\S\):ÞtzpPreformattedTzp&:

  "%s:^--$:ÞtzpPreformattedTzp&:

  v/^ÞtzpPreformattedTzp/ s#^.*https\?://#ÞtzpPreformattedTzp&#

  v:^ÞtzpPreformattedTzp: call SmartQuotesEtc()

  %s:^ÞtzpPreformattedTzp::
  %s:^ÞtzpItemBodyTzp::
  %s:\(Þ\)tzpThornTzp:\1:g

  norm `y
endfunc


func! Toggle01(...)
  if a:0
    let b:toggle01value = 1
  else
    if !exists('b:toggle01value')
      let b:toggle01value = 1
    endif
    let b:toggle01value = !b:toggle01value
    return b:toggle01value
  endif
endfunc
