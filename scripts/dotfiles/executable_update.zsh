#!/bin/zsh
: '
                                                                             _____
          _____        _____                _____   ______   _______    _____\    \
         |\    \_    /      |_         _____\    \_|\     \  \      \  /    / |    |
         \ \     \  /         \       /     /|     |\\     \  |     /|/    /  /___/|
          \|      ||     /\    \     /     / /____/| \|     |/     //|    |__ |___|/
           |      ||    |  |    \   |     | |____|/   |     |_____// |       \
   ______  |      ||     \/      \  |     |  _____    |     |\     \ |     __/ __
  /     / /      /||\      /\     \ |\     \|\    \  /     /|\|     ||\    \  /  \
 |      |/______/ || \_____\ \_____\| \_____\|    | /_____/ |/_____/|| \____\/    |
 |\_____\      | / | |     | |     || |     /____/||     | / |    | || |    |____/|
 | |     |_____|/   \|_____|\|_____| \|_____|    |||_____|/  |____|/  \|____|   | |
  \|_____|                                  |____|/                         |___|/

  https://github.com/Jacke/- iam ~ Dotfiles project
'
function header() {
	echo -e "$(tput sgr 0 1)$(tput setaf 6)$1$(tput sgr0)"
}
function exists() {
    command -v "$1" >/dev/null 2>&1
}

function fun-exists() {
  whence -w $1 >/dev/null
}
function render-logo() {
  less -FX $1/misc/dotfiles-update-logo
}

# TODO: Update arguments
# dotfiles-update [all | plugins | system | ...]
CURRENT_PATH=$(realpath $0)
DIR_PATH=$(dirname $CURRENT_PATH)
render-logo $DIR_PATH


if [[ $OSTYPE == 'darwin'* ]]; then
  header "Updating macOS..."
  sudo softwareupdate -i -a
  brew update -v && brew upgrade -v && brew outdated -v
fi

if [[ $OSTYPE == 'linux'* ]]; then
  header "Updating Linux..."
  if (exists sudo); then
    sudo apt-get update
    sudo apt-get -y upgrade
  else
    apt-get update
    apt-get -y upgrade
  fi
fi

# ZSH Plugins
if [ -d $HOME/.zinit ]; then
  source ~/.zshrc
  header "Updating dotfiles..."
  zinit update
fi

# Node
if (exists npm); then
  header "Updating NodeJS packages..."
  npm upgrade -g
fi

#pushd "$HOME/dotfiles"
#git pull
#./sync.py
#source "$HOME/.bashrc"
#popd
#echo

# Nyan cat! Yay!
# nyan

## Refresher for my .dotfiles

# Dotfiles
# chezmoi cd && git pull upstream --rebase

## **Refresher** [WIP] for dotfiles with user defined content
# sed -n -e '/# IGNORE START/,/# IGNORE END/{ /# IGNORE/d; p }' dot_path
# sed -n -e '/# IGNORE START/,/# IGNORE END/{ /# IGNORE/d; p }' dot_zshrc.d/plugins.zsh
# OP=`sed -n -e '/# IGNORE START/,/# IGNORE END/{ /# IGNORE/d; p }' dot_path`
# if [ -n "$OP" ]; then
#  echo "there is output"
# else
#  echo "no output"
# fi
# refresherCopy() { }
# refresherRestore() { }
