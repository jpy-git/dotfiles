#!/usr/bin/env zsh

echo "Install Homebrew Packages"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU commands.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"
brew install ed
brew install findutils
brew install gawk
brew install gnu-sed
brew install gnu-tar
brew install grep
brew install make

# Install a modern version of BASH.
brew install bash
brew install bash-completion@2 # Auto-completion

# Install a modern version of ZSH.
brew install zsh
brew install zsh-autosuggestions # Auto-completion
brew install zsh-syntax-highlighting # Syntax highlighting

# Switch to using brew-installed ZSH as default shell.
if ! fgrep -q "${BREW_PREFIX}/bin/zsh" /etc/shells; then
  echo "${BREW_PREFIX}/bin/zsh" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/zsh";
fi;

# Install useful binaries.
brew install git # Latest git
brew install gh # GitHub CLI
brew install rlwrap # readline wrapper
brew install nano # Latest nano
brew install ack # Text finder
brew install imagemagick # Image editing
brew install tree # Recursive directory listing
brew install bat # cat replacement
brew install exa # ls replacement
brew install colordiff # diff replacement
brew install htop # Interactive process viewer
brew install hyperfine # Benchmarking tool
brew install neofetch # System information tool
brew install z # Jump around directories
brew install jq # JSON processor
brew install xo/xo/usql # Universal CLI for SQL databases
brew install shellcheck # Linter for shell scripts

# Programming languages.
brew install python@3.8
brew install python@3.9
brew install python@3.10
brew install go

# Casks.
brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask docker
brew install --cask miniforge
brew install --cask google-chrome
brew install --cask amethyst

# Apply Amethyst settings.
[[ -f "${HOME}/Library/Preferences/com.amethyst.Amethyst.plist" ]] && rm "${HOME}/Library/Preferences/com.amethyst.Amethyst.plist"
cp "./amethyst/com.amethyst.Amethyst.plist" "${HOME}/Library/Preferences"

# Remove outdated versions from the cellar.
brew cleanup && brew autoremove
