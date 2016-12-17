" last change 2015-11-29
" Dorai Sitaram

"needed only if called from within lynx

if $LYNX_VERSION == ""
  finish
endif

au bufread *.html setl noswf

let s:lynx_source_files = []

au bufenter *.html call s:txt_go_to_source_file()

func! s:txt_go_to_source_file()
  let generated_by_asciidoctor_p = 0
  let generated_by_pandoc_p = 0
  let generated_by_tex2page_p = 0
  let generated_by_troff2page_p = 0
  let generated_by_txt2page_p = 0
  "check if html file was generated
  sil! 1,5g/^Generated from .\{-} by txt2page/
        \ let generated_by_txt2page_p = 1
  sil! 1,5g/^Generated from .\{-} by troff2page/
        \ let generated_by_troff2page_p = 1
  sil! 1,5g/^Generated from .\{-} by tex2page/
        \ let generated_by_tex2page_p = 1
  sil! 1,8g/<meta name="generator" content="pandoc"/
        \ let generated_by_pandoc_p = 1
  sil! 1,8g/<meta name="generator" content="Asciidoctor.\{-}">/
        \ let generated_by_asciidoctor_p = 1
  if !generated_by_txt2page_p && !generated_by_troff2page_p &&
        \ !generated_by_tex2page_p && !generated_by_pandoc_p &&
        \ !generated_by_asciidoctor_p
    return
  endif
  "if generated, edit source file
  if generated_by_txt2page_p || generated_by_troff2page_p || generated_by_tex2page_p
    0
    /^Generated from/
    norm 2wgf
    if generated_by_txt2page_p
      doau bufread pretend.txt "shouldn't be needed, but is!
      setl mp=txt2page\ %
    elseif generated_by_troff2page_p
      setl mp=troff2page.lisp\ %
    else
      setl mp=tex2page.lisp\ %
    endif
  elseif generated_by_pandoc_p || generated_by_asciidoctor_p
    let l:source_file = ''
    let l:old_su = &su
    let &su .= ',.cpt,.docx,.html,.pdf,.txt\.so'
    for l:source_file_try in glob(expand('%:r') . '.*', 0, 1)
      if filereadable(l:source_file_try)
        let l:source_file = l:source_file_try
        break
      endif
    endfor
    let &su = l:old_su
    if l:source_file != ''
      exec 'e' l:source_file
      if generated_by_asciidoctor_p
        setl mp=adoc\ %
      else
        setl mp=pandoc
              \\ -f\ markdown-line_blocks-raw_html-subscript-superscript+autolink_bare_uris
              \\ -t\ html5
              \\ -c\ default.css
              \\ -s
              \\ %\ -o\ %:r.html
      endif
    endif
  endif
  "when writing source file, remember to refresh the html
  exec 'au bufwritepost' expand('%') 'call s:remember_to_refresh_html()'
endfunc

func! s:remember_to_refresh_html()
  let this_file = expand('%:p')
  if index(s:lynx_source_files, this_file) < 0
    call add(s:lynx_source_files, this_file)
  endif
endfunc

au vimleave * call s:back_to_lynx()

func! s:back_to_lynx()
  for file in s:lynx_source_files
    exec 'b' file
    lcd %:p:h
    make
  endfor
endfunc
