####################################################################################################################################
##########################             Terminal Utilities             ##############################################################
##########################         https://dotfiles.download          ##############################################################
####################################################################################################################################
# References:
#
# Set terminal window and tab/icon title
#
# usage: title short_tab_title [long_window_title]
#
# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# Fully supports screen, iterm, and probably most modern xterm and rxvt
# (In screen, only short_tab_title is used)
# Limited support for Apple Terminal (Terminal can't set window and tab separately)
function title {
  setopt localoptions nopromptsubst

  # Don't set the title if inside emacs, unless using vterm
  [[ -n "${INSIDE_EMACS:-}" && "$INSIDE_EMACS" != vterm ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  case "$TERM" in
    cygwin|xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*|foot)
      print -Pn "\e]2;${2:q}\a" # set window name
      print -Pn "\e]1;${1:q}\a" # set tab name
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\" # set screen hardstatus
      ;;
    *)
      if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
        print -Pn "\e]2;${2:q}\a" # set window name
        print -Pn "\e]1;${1:q}\a" # set tab name
      else
        # Try to use terminfo to set the title if the feature is available
        if (( ${+terminfo[fsl]} && ${+terminfo[tsl]} )); then
          print -Pn "${terminfo[tsl]}$1${terminfo[fsl]}"
        fi
      fi
      ;;
  esac
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m:%~"
# Avoid duplication of directory in terminals with independent dir display
if [[ "$TERM_PROGRAM" == Apple_Terminal ]]; then
  ZSH_THEME_TERM_TITLE_IDLE="%n@%m"
fi

# Runs before showing the prompt
function omz_termsupport_precmd {
  [[ "${DISABLE_AUTO_TITLE:-}" != true ]] || return
  title "$ZSH_THEME_TERM_TAB_TITLE_IDLE" "$ZSH_THEME_TERM_TITLE_IDLE"
}

# Runs before executing the command
function omz_termsupport_preexec {
  [[ "${DISABLE_AUTO_TITLE:-}" != true ]] || return

  emulate -L zsh
  setopt extended_glob

  # split command into array of arguments
  local -a cmdargs
  cmdargs=("${(z)2}")
  # if running fg, extract the command from the job description
  if [[ "${cmdargs[1]}" = fg ]]; then
    # get the job id from the first argument passed to the fg command
    local job_id jobspec="${cmdargs[2]#%}"
    # logic based on jobs arguments:
    # http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
    # https://www.zsh.org/mla/users/2007/msg00704.html
    case "$jobspec" in
      <->) # %number argument:
        # use the same <number> passed as an argument
        job_id=${jobspec} ;;
      ""|%|+) # empty, %% or %+ argument:
        # use the current job, which appears with a + in $jobstates:
        # suspended:+:5071=suspended (tty output)
        job_id=${(k)jobstates[(r)*:+:*]} ;;
      -) # %- argument:
        # use the previous job, which appears with a - in $jobstates:
        # suspended:-:6493=suspended (signal)
        job_id=${(k)jobstates[(r)*:-:*]} ;;
      [?]*) # %?string argument:
        # use $jobtexts to match for a job whose command *contains* <string>
        job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
      *) # %string argument:
        # use $jobtexts to match for a job whose command *starts with* <string>
        job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
    esac

    # override preexec function arguments with job command
    if [[ -n "${jobtexts[$job_id]}" ]]; then
      1="${jobtexts[$job_id]}"
      2="${jobtexts[$job_id]}"
    fi
  fi

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD="${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}"
  local LINE="${2:gs/%/%%}"

  title "$CMD" "%100>...>${LINE}%<<"
}

# Keep Apple Terminal.app's current working directory updated
# Based on this answer: https://superuser.com/a/315029
# With extra fixes to handle multibyte chars and non-UTF-8 locales
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then
  # Emits the control sequence to notify Terminal.app of the cwd
  # Identifies the directory using a file: URI scheme, including
  # the host name to disambiguate local vs. remote paths.
  function update_terminalapp_cwd() {
    emulate -L zsh

    # Percent-encode the host and path names.
    local URL_HOST URL_PATH
    URL_HOST="$(omz_urlencode -P $HOST)" || return 1
    URL_PATH="$(omz_urlencode -P $PWD)" || return 1

    # Undocumented Terminal.app-specific control sequence
    printf '\e]7;%s\a' "file://$URL_HOST$URL_PATH"
  }

  # Use a precmd hook instead of a chpwd hook to avoid contaminating output
  add-zsh-hook precmd update_terminalapp_cwd
  # Run once to get initial cwd set
  update_terminalapp_cwd
fi
# terminal titles & vcs refresh
case $TERM in
  *xterm*)
    precmd() {
      print -nP "\033]0;%m: %3~\007"
    }
    preexec() {
      print -nP "\033]0;%m: $1\007"
    }
  ;;
  *screen*|*tmux*)
    precmd() {
      print -nP "\ek%3~\e\\"
      print -nP "\e]0;%3~\a"
      # session-name: dir
      # print -nP "\033]0;${(C)$(tmux display-message -p '#S')}: %3~\007"
      print -nP "\033]0;$(tmux display-message -p '#S'): %3~\007"
    }
    preexec() {
      print -nP "\ek%3~ $1\e\\"
      print -nP "\e]0;%3~ $1\a"
      # session-name: cmd
      # print -nP "\033]0;${(C)$(tmux display-message -p '#S')}: $1\007"
      print -nP "\033]0;$(tmux display-message -p '#S'): $1\007"
    }
  ;;
esac

# change cursor depending on mode
if [ "$TERM_PROGRAM" = "iTerm.app" -o "$TERM_PROGRAM" = "iTerm2.app" -o "$TERM_PROGRAM" = "Hyper" -o "$TERM_PROGRAM" = "kitty" ]; then
  function zle-keymap-select zle-line-init {
    if [[ $TMUX != "" ]]; then
      case $KEYMAP in
        vicmd)      print -n -- "\033Ptmux;\033\E]50;CursorShape=0\C-G\033\\";;
        viins|main) print -n -- "\033Ptmux;\033\E]51;CursorShape=1\C-G\033\\";;
      esac
    else
      case $KEYMAP in
        vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;
        viins|main) print -n -- "\E]51;CursorShape=1\C-G";;
      esac
    fi

    zle reset-prompt
    zle -R
  }
  zle -N zle-line-init
  zle -N zle-keymap-select
  function zle-line-finish {
    if [[ $TMUX != "" ]]; then
      print -n -- "\033Ptmux;\033\E]50;CursorShape=0\C-G\033\\"
    else
      print -n -- "\E]50;CursorShape=0\C-G"
    fi
  }
  zle -N zle-line-finish
fi
