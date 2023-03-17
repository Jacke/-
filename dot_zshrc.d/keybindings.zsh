####################################################################################################################################
##########################            Keybindings                   ################################################################
##########################      https://dotfiles.download           ################################################################
####################################################################################################################################
# ^  – Control
# ^A - Control + A
# ^[ - Escape or Alt
#  ACTION:               DEFAULT    BINDINGS (NOTES):
#    abort                 ctrl-c    ctrl-q  esc
#    accept                enter
#    backward-word         opt-left  shift-left
#    beginning-of-line     ctrl-a    home
#    clear-screen          ctrl-l
#    down                  ctrl-j     ctrl-n  down
#    end-of-line           ctrl-e     end
#    forward-char          ctrl-f     right
#    forward-word          alt-f      shift-right
#    kill-line             ctrl-a
#    kill-word             alt-d
##############################################
##############################################
# General                                    #
bindkey-safe() { [[ -n "$1" ]] && bindkey -M $BIND_OPTION "$1" "$2" }
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
bindkey -M menuselect '^[[Z' reverse-menu-complete # shift+tab
# ** [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) 
# ** 🐠 ZSH port of Fish history search (up arrow)
if (zplugin-exists "zsh-users/zsh-history-substring-search"); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi
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
