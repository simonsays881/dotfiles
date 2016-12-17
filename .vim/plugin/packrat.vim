" last modified 2016-06-14
" Dorai Sitaram

"a file is backed up at most once per vi session.
"The file as it was just before the session is considered to be
"the "original".
"The backup suffix depends on when the session was started

let &pm = strftime('.%Y-%m-%dT%H:%M~')

"before writing a file, check if its original was already backed up in 'bdir'.
"If so, copy it to working dir. This prevents creation of a new backup

au bufwritepre * call s:copyOldBackupToWd()

func! s:copyOldBackupToWd()
  let backupTailname = expand('%:t') . &pm
  let backupInBdir = findfile(backupTailname, &bdir)
  if !empty(backupInBdir)
    let backupInWd = expand('%') . &pm
    call rename(backupInBdir, backupInWd)
  endif
endfunc

"after writing a file, there will be an original in the working dir,
"possibly just created. Copy it to 'bdir', unless it's an empty file

au bufwritepost * call s:copyBackupToBdir()

func! s:copyBackupToBdir()
  let backupInWd = expand('%') . &pm
  if filereadable(backupInWd)
    if empty(readfile(backupInWd, '', 1))
      call delete(backupInWd)
    else
      let backupTailname = expand('%:t') . &pm
      let lastBdir = split(&bdir, ',')[-1]
      let backupInBdir = lastBdir . '/' . backupTailname
      call rename(backupInWd, backupInBdir)
    endif
  endif
endfunc
