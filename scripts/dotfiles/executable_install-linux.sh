#!/bin/zsh
### Dotfiles (iam) project v1.0.0
### [Stan S](https://github.com/Jacke/-)
### Copyright 2020-2022
### <\*/>
set -euo pipefail
if [[ "$DOCKER" -eq 1 ]]; then
	full_path=$(realpath $0)
	dir_path=$(dirname $full_path)
	source $INSTALL_COMMON
else
	source <(curl -sL https://raw.githubusercontent.com/Jacke/-/main/scripts/dotfiles/executable_install-common.sh)
fi

# Install essential packages
PACKAGES="git zsh exa zoxide nano python3 python-pip silversearcher-ag wget fzf"
## TODO: Replace it with:
#                       *> unipack install Jacke/minimal-dotfiles
if exists sudo; then
	sudo apt-get update
	sudo apt-get -y install git zsh exa zoxide nano python3 python-pip silversearcher-ag wget fzf
else
	apt-get update
	apt-get -y install git zsh exa zoxide nano python3 python-pip silversearcher-ag wget fzf
fi

# Chezmoi – the best dotfiles manager
if ! exists chezmoi; then
	sh -c "$(curl -fsLS https://chezmoi.io/get)"
	cp ./bin/chezmoi /bin/
fi

# Atuin – shell history app
if ! exists atuin; then
	bash <(curl https://raw.githubusercontent.com/ellie/atuin/main/install.sh)
fi

# Zinit – zsh plugin manager
if ! exists zinit; then
	export NO_EDIT=1
	export NO_TUTORIAL=1
	export NO_INPUT=1
	sh -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

# powerlevel10k – the best shell prompt
if [[ ! -d /opt/powerlevel10k ]]; then
	mkdir -p /opt
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /opt/powerlevel10k
fi

# asdf – the best version manager for your tools
if [[ ! -d ~/.asdf ]]; then
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
fi

# Core installation
###
core_install
