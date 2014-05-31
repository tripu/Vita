# ~/.bashrc: executed by bash(1) for non-login shells.

# Source global definitions

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.profile ]; then
	. ~/.profile
fi

# User specific aliases and functions

PATH=~/pear/pear:$PATH


