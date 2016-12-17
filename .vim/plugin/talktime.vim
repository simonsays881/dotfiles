" last modified 2016-10-23

let s:words_per_minute = 124

func! s:time_to_speak_curr_file()
  let l:old_statusmsg = v:statusmsg
  exec "sil norm g\<c-g>"
  let l:word_count = str2float(split(v:statusmsg)[11])
  let v:statusmsg = l:old_statusmsg
  let l:minutes = l:word_count / s:words_per_minute
  let l:whole_minutes = float2nr(l:minutes)
  let l:seconds = float2nr(round((l:minutes - l:whole_minutes) * 60))
  return l:whole_minutes . 'm ' . l:seconds . 's'
endfunc

com! Talk echo s:time_to_speak_curr_file()
