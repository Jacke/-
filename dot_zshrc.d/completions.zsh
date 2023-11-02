####################################################################################################################################
##########################   Completions, Corrections, Shortcuts    ################################################################
##########################      https://dotfiles.download           ################################################################
####################################################################################################################################
export BAT_PAGER="less -irRSx4"
export YARN_ENABLED=true
export TOUCHBAR_GIT_ENABLED=true

if [[ "$DOTFILES_CORRECTION" == "zsh" ]]; then
  setopt correct
  setopt correct_all
  if [ -f ~/.zsh_nocorrect ]; then
      while read -r COMMAND; do
          alias $COMMAND="nocorrect $COMMAND"
      done < ~/.zsh_nocorrect
  fi
else
  unsetopt correct
  unsetopt correct_all
fi
####################################################################################################################################
##########################         **Completion**                   ################################################################
####################################################################################################################################
# On slow systems, checking the cached .zcompdump file to see if it must be 
# regenerated adds a noticable delay to zsh startup.  This little hack restricts 
# it to once a day.  It should be pasted into your own completion file.
#
# The globbing is a little complicated here:
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
# - '.' matches "regular files"
# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
function init_static_compinit() {
  autoload -Uz compinit
  autoload -U +X bashcompinit
  for dump in ~/.zcompdump(N.mh+24); do
    compinit
    bashcompinit
  done
  compinit -C
  bashcompinit -C
  complete -o nospace -C /usr/local/bin/bitcomplete bit
}

function init_autocomplete() {
  zinit wait'1' lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
      zsh-users/zsh-syntax-highlighting \
      marlonrichert/zsh-autocomplete \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
}

function init_vanilla() {
  zinit wait'1' lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
      zsh-users/zsh-syntax-highlighting \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
  # ** [Vanilla OMZ completion](https://github.com/ohmyzsh/ohmyzsh/lib/completion.zsh) **
  zplugin ice depth=1 wait'1' lucid
  zplugin snippet OMZ::lib/completion.zsh
}

function init_fzf_complete() {
  # TODO: Add fzf shell menu
  # ** [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete) **
  # ** [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions) **
  # ** [fzf-tab](https://github.com/Aloxaf/fzf-tab) ** 
  # zinit light Aloxaf/fzf-tab NOT STABLE BECAUSE 
  # fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting!!

  # keep the default fzf
  #zstyle ":completion:*" list-colors off
  #zstyle ':autocomplete:tab:*' completion fzf
  #zstyle ":completion:*" list-colors fzf
  # zstyle ':autocomplete:*' fuzzy-search off
  # bindkey '^I' fzf-completion # ?????????????
}
#######################################################
#                       TODO
#######################################################
case $COMPLETION in
  AUTOCOMPLETE)
  init_autocomplete
    ;;
  *)
  init_vanilla
  ;;
esac

# TODO: Add completion as compdef _gnu_generic cached_exec
# TODO: Add sgortkey to disabled auto completion session based on ENV variable (easy as hell)
# function completion-toggle() {
  # if (( ${+POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND} )); then
    # unset POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND
  # else
    # POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern|kubeseal|skaffold|kubent'
  # fi#
  # p10k reload
  # if zle; then
    # zle push-input
    # zle accept-line
  # fi
# }
# zle -N completion-toggle
# bindkey '^]' completion-toggle  # Bind ctrl-] to toggle completion
