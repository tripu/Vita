# ~/.bash_profile: executed by bash(1) for login shells.

# Get the aliases and functions

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH
umask 002
# PS1='[\h]$ '
# PS1='\u@\h:\w\$ '
# PS1='\e[30;1m\u@\h:\e[37;1m\w\e[30;1m$\e[0m '
PS1='\u@\h:\e[37;1m\w\e[0m$ '
eval `dircolors`
source .alias
PATH=~/pear/pear:$PATH

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

