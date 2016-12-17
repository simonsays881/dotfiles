"call EnsurePlugin('https://github.com/maxboisvert/vim-simple-complete')
"last modified 2016-11-22
au bufread * sil! norm g`"
call EnsurePlugin('https://github.com/guns/xterm-color-table.vim')
call EnsurePlugin('https://github.com/jarrodctaylor/spartan')
call EnsurePlugin('https://github.com/luochen1990/rainbow')
if &uc == 10000 | nmap q :q<cr> | endif
ino <tab> <c-n>
ino j' `
ino jj <esc>
let g:rainbow_conf = {}
let g:rainbow_conf.ctermfgs = [129, 33, 64, 136, 166, 88]
let syntax_cmd = 'enable'
ru syntax/syncolor.vim
