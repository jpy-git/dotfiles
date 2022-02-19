# History
HISTCONTROL=ignoredups
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=1000
HISTFILE="$HOME/.cache/bash/history"

# Prompt
PS1="\`if [ \$? = 0 ]; then echo \\[\\033[1';'32m\\]٩\(^‿^\)۶\[\e[0m\]; else echo \\[\\033[1';'31m\\]٩\(ಠ_ಠ\)۶\[\e[0m\]; fi\` \[\033[1;34m\]\W $\[\e[0m\] "

# Aliases
alias ..='cd ..'
alias ls='exa --icons -a --group-directories-first'
alias ll='ls -Ahl'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias brave='open -na "Brave Browser"'
alias neofetch="neofetch --iterm2 \"$HOME/.config/neofetch/baby_penguin.png\" --image_size none"

# Z command
source "$(brew --prefix)/etc/profile.d/z.sh"
