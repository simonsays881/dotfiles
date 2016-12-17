 " last change 2016-11-28
 au bufwritepre sortf.vim mark x | %sort iu | norm 'x
au bufwritepre .aliases* do bufwritepre sortf.vim
au bufwritepre .gitignore do bufwritepre sortf.vim
au bufwritepre .infokey do bufwritepre sortf.vim
au bufwritepre .npmignore do bufwritepre sortf.vim
au bufwritepre .vimrc do bufwritepre sortf.vim
au bufwritepre .XCompose do bufwritepre sortf.vim
au bufwritepre hilite*.vim do bufwritepre sortf.vim
au bufwritepre misc*.vim do bufwritepre sortf.vim
au bufwritepre paideia.adoc do bufwritepre sortf.vim
au bufwritepre rightleft.tex do bufwritepre sortf.vim
