####################################################################################################################################
##########################              History                     ################################################################
##########################      https://dotfiles.download            ################################################################
####################################################################################################################################
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S - '
export PROMPT_COMMAND='history -a'
## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
export HISTCONTROL=ignoredups:ignorespace

##############################################
# Options                                    #
# new history lines are added incrementally as soon as they are entered,
# rather than waiting until the shell exits
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt hist_reduce_blanks     # Remove blanks from each command line being added to the history list.
setopt inc_append_history     # History lines are added immediately, not just when the shell exits.
setopt append_history         # With this set, zsh sessions will append to, not replace, the history file.
# Remove older duplicate entries from history
setopt hist_ignore_all_dups
setopt hist_save_nodups

## History wrapper
function dotfiles_history {
  local clear list
  zparseopts -E c=clear l=list

  if [[ -n "$clear" ]]; then
    # if -c provided, clobber the history file
    echo -n >| "$HISTFILE"
    fc -p "$HISTFILE"
    echo >&2 History file deleted.
  elif [[ -n "$list" ]]; then
    # if -l provided, run as if calling `fc' directly
    builtin fc "$@"
  else
    # unless a number is provided, show all history events (starting from 1)
    [[ ${@[-1]-} = *[0-9]* ]] && builtin fc -l "$@" || builtin fc -l "$@" 1
  fi
}

# Timestamp format
case ${HIST_STAMPS-} in
  "mm/dd/yyyy") alias history='dotfiles_history -f' ;;
  "dd.mm.yyyy") alias history='dotfiles_history -E' ;;
  "yyyy-mm-dd") alias history='dotfiles_history -i' ;;
  "") alias history='dotfiles_history' ;;
  *) alias history="dotfiles_history -t '$HIST_STAMPS'" ;;
esac
