#!/usr/bin/env zsh

# Install xcode.
if ! command -v xcode-select &> /dev/null
    then
    echo "Install xcode"
    xcode-select --install
    echo
fi

# Install Rosetta
echo "Install Rosetta"
sudo softwareupdate --install-rosetta
echo

# Install Homebrew.
if ! command -v brew &> /dev/null
    then
    echo "Install Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo
fi

# Install Powerlevel10k.
[[ ! -d "$HOME/.config/powerlevel10k" ]] && echo "Install Powerlevel10k" && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.config/powerlevel10k" && echo
cd "$HOME/.config/powerlevel10k" && git pull > /dev/null
cd ~-

# Install AWS CLI.
if ! command -v aws &> /dev/null
    then
    echo "Install AWS CLI"
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /
    rm AWSCLIV2.pkg
    echo
fi

# Link dotfiles to home directory.
DOTFILES_DIR="$(pwd -P)/dotfiles/"
echo "Symlink dotfiles"
for src in $(find "$DOTFILES_DIR" -type f)
do
    dst="$HOME/${src#$DOTFILES_DIR}"
    [[ ! -d "$(dirname $dst)" ]] && mkdir -p "$(dirname $dst)"
    rm -rf "$dst"
    ln -s "$src" "$dst"
done
source ~/.zshrc
echo

# Create ~/bin if not exists.
[[ ! -d "$HOME/bin" ]] && mkdir "$HOME/bin"

# Install cht.sh.
if ! command -v cht.sh &> /dev/null
    then
    echo "Install cht.sh"
    curl https://cht.sh/:cht.sh > "$HOME/bin/cht.sh"
    chmod +x  "$HOME/bin/cht.sh"
    curl https://cheat.sh/:zsh > "$(brew --prefix)/share/zsh/site-functions/_cht"
    echo
fi
