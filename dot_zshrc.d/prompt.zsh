####################################################################################################################################
##########################             MOTD                         ################################################################
####################################################################################################################################
if [[ -r "$HOME/Scripts/bin/cache_out" ]]; then
  eval "cache_out neofetch" # Faster shell startup
else
  eval "neofetch --disable cols"
fi
####################################################################################################################################
##########################        **Powerlevel10k PROMPT**          ################################################################
####################################################################################################################################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
if (is-macos); then
  source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
fi
if (is-linux); then
  source /opt/powerlevel10k/powerlevel10k.zsh-theme
fi
autoload -U promptinit; promptinit
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
