# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path
typeset -U PATH path # Remove duplicates in PATH

# Add appropriate Homebrew to PATH
if [[ $(arch) == arm64 ]]; then
  HOMEBREW_PREFIX="/opt/homebrew"
else
  HOMEBREW_PREFIX="/usr/local"
fi

eval "$(unset HOMEBREW_SHELLENV_PREFIX && $HOMEBREW_PREFIX/bin/brew shellenv)"

export GOPATH="$HOME/go" # Go
export GOROOT="$(brew --prefix golang)/libexec"

path=(
    "$HOME/bin"
    "$(brew --prefix)/opt/python@3.9/bin" # Python 3.9
    "$(brew --prefix)/opt/python@3.8/bin" # Python 3.8
    "$(brew --prefix)/opt/python@3.10/bin" # Python 3.10
    "${GOPATH}/bin"
    "${GOROOT}/bin"
    $path
    "/usr/local/aws/bin" # AWS autocompleter
)

# GNU commands
GNUBINS=()
while read gnubin; do
    GNUBINS+=("$gnubin")
done < <(find "$(brew --prefix)/opt" -type d -follow -name gnubin -print)
export GNUBINS

for gnubin in "${GNUBINS[@]}"; do
    export PATH=$gnubin:$PATH
done;

# ZSH formatting
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/etc/profile.d/z.sh"
source "$HOME/.config/powerlevel10k/powerlevel10k.zsh-theme"

# Aliases
alias ..='cd ..'
alias ls='exa --icons -a --group-directories-first'
alias ll='ls -l'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias chrome='open -na "Google Chrome"'
alias neofetch="neofetch --iterm2 \"$HOME/.config/neofetch/baby_penguin.png\" --image_size none"

# History
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt inc_append_history
export HISTSIZE=1000
export SAVEHIST=1000
HISTDIR="$HOME/.cache/zsh"
[[ ! -e "$HISTDIR" ]] && mkdir "$HISTDIR"
export HISTFILE="$HISTDIR/history"

# Help
unalias run-help 2> /dev/null
autoload run-help

# Enable auto-completion
eval "$(python3.10 -m pip completion --zsh)"
chmod -R go-w "$(brew --prefix)/share"
fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Include hidden files/folders in tab completion
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Enable AWS CLI tab completion
complete -C '/usr/local/bin/aws_completer' aws

# Conda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(\"$(brew --prefix)/Caskroom/miniforge/base/bin/conda\" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$(brew --prefix)/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "$(brew --prefix)/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="$(brew --prefix)/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Initialise Powerlevel10k instant prompt
[[ ! -f "$HOME/.config/.p10k.zsh" ]] || source "$HOME/.config/.p10k.zsh"
