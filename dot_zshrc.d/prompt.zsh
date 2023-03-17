####################################################################################################################################
##########################        ** Powerlevel10k Prompt **          ##############################################################
##########################         https://dotfiles.download          ##############################################################
####################################################################################################################################
# * To customize prompt, run `p10k configure` or edit ~/.p10k.zsh. *
function dotfiles_p10k_init_theme() {
  if (is-macos); then
    source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
  fi
  if (is-linux); then
    source /opt/powerlevel10k/powerlevel10k.zsh-theme
  fi
}

function dotfiles_p10k_init_config() {
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
}

function dotfiles_p10k_init() {
  dotfiles_p10k_init_theme
  dotfiles_p10k_init_config
}

function dotfiles_p10k_instant() {
  # * Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc. *
  # * Initialization code that may require console input (password prompts, [y/n] *
  # * confirmations, etc.) must go above this block; everything else may go below. *
  (( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    dotfiles_p10k_init
  else
    dotfiles_p10k_init
  fi
  (( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"
}
dotfiles_p10k_instant
