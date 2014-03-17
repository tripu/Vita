# ~/.bash_profile: executed by bash(1) for login shells.

umask 002
# PS1='[\h]$ '
# PS1='\u@\h:\w\$ '
# PS1='\e[30;1m\u@\h:\e[37;1m\w\e[30;1m$\e[0m '
PS1='\u@\h:\e[37;1m\w\e[0m$ '
eval `dircolors`
source .alias
PATH=~/pear/pear:$PATH

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
