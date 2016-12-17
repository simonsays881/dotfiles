# last change 2016-07-20

set -o vi

shopt -s cdspell
shopt -s extglob
shopt -s globstar
shopt -s nocaseglob
shopt -s autocd

# in ~/.inputrc put
# set completion-ignore-case on

#export PATH=.:/usr/local/heroku/bin:$PATH

#xkbset ma 60 10 10 5 2
#xkbset ma 60 10 20 5 1
xkbset ma 60 40 30 5 1

setxkbmap -option caps:ctrl_modifier

. ~/.env

. ~/.aliases
