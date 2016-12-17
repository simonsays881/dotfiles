" last modified 2016-06-14

au bufwritepost **/sos/*.adoc call s:makeDocx()

func! s:makeDocx()
  let inputFileBasename = expand('%:t:r')
  exec 'sil !asciidoctor % -a noheader -a nofooter -a sectnums -o - | '
        \. 'pandoc -f html -o ' . inputFileBasename . '.docx'
endfunc
