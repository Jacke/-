####################################################################################################################################
##########################   Completions, Corrections, Shortcuts    ################################################################
##########################      https://dotfiles.download           ################################################################
####################################################################################################################################
export BAT_PAGER="less -irRSx4"
export YARN_ENABLED=true
export TOUCHBAR_GIT_ENABLED=true

setopt correct
# zstyle ':autocomplete:*' fuzzy-search off
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/bitcomplete bit
# keep the default fzf
zstyle ':autocomplete:tab:*' completion fzf
zstyle ":completion:*" list-colors off
zstyle ":completion:*" list-colors fzf
# bindkey '^I' fzf-completion # ?????????????
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

if [[ "$ENABLE_CORRECTION" == "true" ]]; then
  alias cp='nocorrect cp'
  alias ebuild='nocorrect ebuild'
  alias gist='nocorrect gist'
  alias heroku='nocorrect heroku'
  alias hpodder='nocorrect hpodder'
  alias man='nocorrect man'
  alias mkdir='nocorrect mkdir'
  alias mv='nocorrect mv'
  alias mysql='nocorrect mysql'
  alias sudo='nocorrect sudo'
  alias su='nocorrect su'

  setopt correct_all
fi

#######################################################
#                       TODO
#######################################################

# setopt auto_cd # cd by typing directory name if it's not a command
# setopt correct_all # autocorrect commands
# setopt auto_list # automatically list choices on ambiguous completion
# setopt auto_menu # automatically use menu completion
# setopt always_to_end # move cursor to end if word had one match
# zstyle ':completion:*' menu select # select completions with arrow keys
# zstyle ':completion:*' group-name '' # group results by category
# zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
