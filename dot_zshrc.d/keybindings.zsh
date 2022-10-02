####################################################################################################################################
##########################            Keybindings                   ################################################################
##########################      https://dotfiles.download           ################################################################
####################################################################################################################################
# ^ is usually control
# ^[ actually means Escape or Alt (or meta, if you like emacs)
##############################################
# General                                    #
bindkey -e
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
bindkey "^R" history-incremental-search-backward
bindkey "^i" menu-expand-or-complete
bindkey -s "^[l" "^E|less^M"
bindkey -s "^[c" "^E|"
bindkey -s "^[b" "^E\\"
bindkey "^[b" backward-word # left arrow
bindkey "^[f" forward-word  # right arrow
#bindkey "^[[A" beginning-of-line # Up
#bindkey "^[[B" down-line-or-beginning-search # Down
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line
bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word
bindkey "^_" undo
bindkey "^[q" push-line-or-edit
bindkey "^[g" get-line
##############################################
# Custom                                    #
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
_quote-previous-word-in-single() {
  modify-current-argument '${(qq)${(Q)ARG}}'
  zle vi-forward-blank-word
}
_quote-previous-word-in-double() {
  modify-current-argument '${(qqq)${(Q)ARG}}'
  zle vi-forward-blank-word
}
##############################################
# Powerlevel10k                              #
function kube-toggle() {
  if (( ${+POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND} )); then
    unset POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND
  else
    POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern'
  fi
  p10k reload
  if zle; then
    zle push-input
    zle accept-line
  fi
}
zle -N kube-toggle
bindkey '^[' kube-toggle  # ctrl-] to toggle kubecontext in powerlevel10k prompt
