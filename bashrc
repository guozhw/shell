# bash Prompt.
<<'COMMENT'
export PS1="\e[35m[\\u\e[m@\e[36m\\h \e[33m\\W]\e[1,33m\\$\e[m "
命令解释：
"[\e[35m[\\u: 开头添加中括号"["，当前登录的用户部分使用紫色字体
\e[m@: "@"符号不给配色，使用默认颜色
\e[36m\\h : 主机名称部分使用青色
\e[33m\\W]: 当前所在目录使用黄颜色，在其后面添加中括号"]"
\e[1,33m\\$\e[m ": $符号加粗，使用黄颜色
COMMENT

purple='\e[35m'
cyan='\e[36m'
yellow='\e[33m'
bold_yellow='\e[1,33m'
default='\e[m'

if [ -n "$BASH_VERSION" ]; then
    if [ "$UID" -eq 0 ]; then
        export PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\]"
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
HISTCONTROL=ignoreboth # Don't put duplicate lines or lines starting with space in the history
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT="%d/%m/%y %T "
shopt -s histappend # Append to the history file, don't overwrite it

# Enable bash completion
if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
