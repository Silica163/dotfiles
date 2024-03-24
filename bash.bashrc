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

# completion
[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

#alias
alias diff='diff --color=auto'
alias ip='ip -c'
alias ls='ls --color=auto'
alias grep='grep --color'
alias hexyl='hexyl --color=auto'

alias social="firefox -P social_media"
alias younme="firefox -P just_you_and_me"
alias go_to_school="firefox -P school_profile"

alias sudo="doas"
alias feh="feh --no-fehbg"
alias pip="pipx"

audio_switch (){
	pci=$(wpctl status | grep Sinks -A4 | grep -E [0-9]{2}\.\ Built-in -o | grep -oE [0-9]{2})
	usb=$(wpctl status | grep Sinks -A4 | grep -E [0-9]{2}\.\ uBoom -o | grep -oE [0-9]{2})
	if [[ $1 == "pci" ]] ; then
		wpctl set-default $pci;
	fi
	if [[ $1 == "usb" ]] ; then
		wpctl set-default $usb;
	fi
	if [ -z $1 ] ; then
		next=$(wpctl status | grep Audio -A10 | grep Sinks -A4 | grep -oE "    [0-9]{2}" | grep -oE "[0-9]{2}");
		wpctl set-default $next
	fi
	printf "switch to %s \n" "$(wpctl status | grep Sinks -A4 | grep -oE '\*.+')";
}

au_pci(){
    wpctl set-default $(wpctl status | grep Sinks -A4 | grep -oE [0-9]{2}\.\ Built-in | grep -oE [0-9]{2});
}

au_usb(){
    wpctl set-default $(wpctl status | grep Sinks -A4 | grep -oE [0-9]{2}\.\ uBoom | grep -oE [0-9]{2});
}
ngrok_tcp(){
    port=$1
    ssh-add ~/.ssh/ngrok.tunnel
    ssh -R 0:localhost:$port v2@connect.ngrok-agent.com tcp
}

#env
if [[ $(tty | grep tty) ]]; then
    export PATH="$PATH:$HOME/.local/bin" ; 
fi
export EDITOR="nvim"
export HISTCONTROL=ignoreboth
HISTSIZE=50000
export HISTSIZE=50000

