" last modified 2016-10-27

let s:viewCounter = 0

func! ViewCmdOutput(cmd, args)
  let l:oldTmpFile = split(&bdir, ',')[-1] . '/view.' . a:cmd . '.tmp.' . s:viewCounter
  let s:viewCounter += 1
  let l:tmpFile = split(&bdir, ',')[-1] . '/view.' . a:cmd . '.tmp.' . s:viewCounter
  if bufexists(l:tmpFile)
    exec 'sb ' l:tmpFile
  elseif bufexists(l:oldTmpFile)
    exec 'sb ' l:oldTmpFile
    exec 'e ' l:tmpFile
  else
    exec 'tabe ' l:tmpFile
  endif
  sil exec '%!' . a:cmd . ' ' . a:args
  setl nobl nomod
  let b:viewCmd = a:cmd
  nmap <buffer> K :call ViewCmdOutput(b:viewCmd, expand("<cword>"))<cr>
endfunc

com! -nargs=1 -complete=shellcmd Man call ViewCmdOutput("man", <q-args>)

com! -nargs=1 -complete=shellcmd Info call ViewCmdOutput("info", <q-args>)

com! -nargs=1 Dict call ViewCmdOutput("dict", '"' . <q-args> . '"')

nmap <leader>w :Dict<space>
