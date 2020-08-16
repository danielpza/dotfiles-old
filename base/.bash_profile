#
# ~/.bash_profile
#

source ~/.profile

[ -z "$DISPLAY" -a "$(tty)" = '/dev/tty1' ] && exec xinit -- vt01

[[ -f ~/.bashrc ]] && . ~/.bashrc

