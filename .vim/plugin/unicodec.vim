"last modified 2016-04-14

":UnicodeChart N
"  shows 256 Unicode characters starting from 0xN
"
":UnicodeChart N P
"  shows the Unicode characters from 0xN to 0xP

com! -nargs=* UnicodeChart call s:unicodeChartFunc(<f-args>)

func! s:unicodeChartFunc(first, ...)
  e ~/tmp/unicode.tmp
  %d
  let l:i = str2nr(a:first, 16)
  if a:0 == 0
    let last = l:i + 0xff
  else
    let last = str2nr(a:1, 16)
  endif
  let l:d = ''
  let l:j = 0
  let l:tblwidth = 8
  while l:i <= last
    let l:c = printf('%04X ', l:i)
    let l:c = l:c . nr2char(l:i)
    let l:i += 1
    let l:d = l:d . '        ' . l:c
    let l:j += 1
    if l:j >= l:tblwidth
      $put =l:d
      let l:d = ''
      let l:j = 0
    endif
  endwhile
  $put =l:d
  1d
  sil w
endfunc
