# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Autocomplete commands prefixed with sudo
complete -cf sudo

# PS1 customisation, shows a red prompt if logged in as root
if [[ ${EUID} == 0 ]] ; then
	export PS1="\[\033[38;5;1m\]\u@\h\[$(tput sgr0)\]:\w\[$(tput sgr0)\]\[\033[38;5;1m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
else
	export PS1="\[\033[38;5;33m\]\u@\h\[$(tput sgr0)\]:\w\[$(tput sgr0)\]\[\033[38;5;11m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
fi

# Aliases
alias ls="ls --color=auto -h --group-directories-first"
alias grep="grep --color=auto"
alias ip="ip --color=auto"
alias clipboard="xclip -sel clip"
alias hg612ctl="hg612ctl.py"
alias torrentctl="torrentctl.py"
alias vpnctl="vpnctl.py"
alias ssh_ignore='ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no"'
alias vim='lvim'

# Path
export PATH="${PATH}:/home/digitaldunc/scripts:/home/digitaldunc/.local/bin/"
