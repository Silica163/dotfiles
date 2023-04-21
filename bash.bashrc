#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ $DISPLAY ]] && shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*|tmux*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

alias diff='diff --color=auto'
alias ip='ip -c'
alias ls='ls --color=auto'
alias grep='grep --color'

alias social="firefox -P social_media"
alias younme="firefox -P just_you_and_me"
alias go_to_school="firefox -P school_profile"

alias sudo="echo Use [doas] please."


audio_switch (){
	audioin=$(wpctl status | grep Sinks -A2 | grep -E [0-9]{2}\.\ Built-in -o | grep -oE [0-9]{2})
	audioex=$(wpctl status | grep Sinks -A2 | grep -E [0-9]{2}\.\ uBoom -o | grep -oE [0-9]{2})
	if [[ $1 == "pci" ]] ; then
		wpctl set-default $audioin;
	fi
	if [[ $1 == "usb" ]] ; then
		wpctl set-default $audioex;
	fi
	if [ -z $1 ] ; then
		next=$(wpctl status | grep Audio -A10 | grep Sinks -A3 | grep -oE "    [0-9]{2}" | grep -oE "[0-9]{2}");
		wpctl set-default $next
	fi
	printf "switch to %s \n" "$(wpctl status | grep Sinks -A3 | grep -oE '\*.+')";
}

alias short_all="sleep 2 && import -window root \"$HOME/Pictures/screenshort/\$(date).png\""

export CONFIG=$HOME/.config/

export HISTCONTROL=ignoredups
HISTSIZE=50000
