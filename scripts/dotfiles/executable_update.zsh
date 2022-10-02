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

exist() {
    command -v "$1" >/dev/null 2>&1
}

# Brew update
if [[ $OSTYPE == 'darwin'* ]]; then
  brew update -v && brew upgrade -v && brew outdated -v
fi

# Apt update
if [[ $OSTYPE == 'linux'* ]]; then
  if (exist sudo); then
    sudo apt-get update && sudo apt-get upgrade
  else
    apt-get update && apt-get upgrade
  fi
fi

# Node
if (exist npm); then
  npm upgrade -g
fi
# ZSH Plugins
if (exist npm); then
  omz update
fi
zinit update

# Dotfiles
chezmoi cd && git pull upstream --rebase 

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
