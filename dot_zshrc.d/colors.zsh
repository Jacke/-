####################################################################################################################################
##########################             COLORS                       ################################################################
##########################      https://dotfiles.download           ################################################################
####################################################################################################################################
autoload -Uz colors
colors
####################################################
# dircolors                                        #
####################################################
(( ${+commands[gdircolors]} )) && dircolors() { gdircolors }
if [ -f ~/.dircolors ]; then
  eval $(dircolors -b ~/.dircolors)
fi
####################################################
#                         GRC                      #
# colorizes nifty unix tools all over the place    #
####################################################
if (( $+commands[grc] )) && (( $+commands[brew] ))
then
  source `brew --prefix`/etc/grc.zsh
fi
# Workaround for Mac OS
if [[ `uname` == "Darwin" ]]; then
  alias netstat="$(whereis netstat)"
fi
####################################################
#            Completion Colors                     #
#       see ~/.zshrc.d/completions.zsh             #
####################################################
zmodload -i zsh/complist # colorful listings
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
local red="%{${fg[red]}%}"
local blue="%{${fg[blue]}%}"
local green="%{${fg[green]}%}"
local cyan="%{${fg[cyan]}%}"
local magenta="%{${fg[magenta]}%}"
local yellow="%{${fg[yellow]}%}"
local gray="%{${fg[gray]}%}"
local default="%{${fg[default]}%}"
