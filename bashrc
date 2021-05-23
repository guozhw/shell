#!/usr/bin/env bash

# Enable Wayland support for Mozilla Firefox
export MOZ_ENABLE_WAYLAND=1

if [ -n "$BASH_VERSION" ]; then
    if [ "$UID" -eq 0 ]; then
        # export PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\]"
        # export PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
        export PS1="\n\[\e[1;30m\][$$:$PPID - \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY:-o} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\$ "
    else
        export PS1="${purple}[\\u${default}@${cyan}\\h ${yellow}\\W]${bold_yellow}\\$\e[m "
    fi
else
    if [ $(id -u) -eq 0 ]; then
        export PROMPT="%{$fg_bold[green]%}[%n@%m%{$reset_color%} %{$fg_bold[white]%}%c%{$fg_bold[green]%}]%(!.#.$)%{$reset_color%} "
    else
        export PROMPT="%{$fg_bold[green]%}[%n@%m%{$reset_color%} %{$fg_bold[white]%}%c%{$fg_bold[green]%}]%(!.#.$)%{$reset_color%} "
    fi
fi

OS=`uname -s`
if [[ "$OS" == 'Linux' ]]; then
    export LS_COLORS='no=00:fi=00:di=38;5;117:ln=38;5;214:ex=38;5;10:';
fi

# Alias.
if [[ "$OS" == 'Linux' ]]; then
    alias ls='ls --color=auto'
elif [[ "$OS" == 'Darwin' ]]; then # OSX
    alias ls='ls -G'
fi
alias ll='ls -hl'
alias grep='grep --color'
alias fuck='sudo $(history -p \!\!)'

# History.
export HISTCONTROL=ignorespace:erasedups # Don't put duplicate lines or lines starting with space in the history
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S] "
shopt -s histappend # Append to the history file, don't overwrite it

# Enable bash completion
if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
