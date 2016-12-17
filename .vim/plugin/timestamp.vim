" last modified 2016-07-14

au bufwritepre * call Timestamp()

func! Timestamp()
  norm mx
  sil! /\c^.*last\s\+\%(change\|modified\|update\)\&^.*\<\d\{4}[-–]\d\{2}[-–]\d\{2}\>/
        \ s/\<\d\{4}[-–]\d\{2}[-–]\d\{2}\>/\=strftime('%Y-%m-%d')/
  sil! /\c^.*last\s\+\%(change\|modified\|update\)\&^.*\<\d\{8}\>/
        \ s/\<\d\{8}\>/\=strftime('%Y%m%d')/
  norm `x
endfunc
