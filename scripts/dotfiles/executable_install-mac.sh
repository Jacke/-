#!/bin/bash
### Dotfiles (iam) project v1.0.0
### [Stan S](https://github.com/Jacke/-)
### Copyright 2020-2022
### <\*/>

full_path=$(realpath $0)
dir_path=$(dirname $full_path)
source <(curl -sL https://raw.githubusercontent.com/Jacke/-/main/scripts/dotfiles/executable_install-common.sh)

# Install essential packages
## Git & Make
if !(exist git); then
	sudo softwareupdate -i -a
	xcode-select --install
fi

# Homebrew package manager
if !(exist brew); then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ** Essentials **
## TODO: Replace it with unipack install Jacke/minimal-dotfiles
brew install chezmoi zsh exa ccat zoxide atuin asdf the_silver_searcher neofetch
brew install romkatv/powerlevel10k/powerlevel10k

if !(exist zinit); then
	curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

# Core installation
###
core_install()
