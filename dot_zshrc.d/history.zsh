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
export HISTFILE=~/.zsh_history
export HISTSIZE=150000
export SAVEHIST=50000
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
export HISTCONTROL=ignoredups:ignorespace

##############################################
# Options                                    #
# Save timestamp and the duration as well into the history file.
setopt extended_history

# new history lines are added incrementally as soon as they are entered,
# rather than waiting until the shell exits
setopt inc_append_history

# share history between different instances of the shell
setopt share_history 

# If this is set, zsh sessions will append their history list to the history file, rather than replace it
setopt append_history

# If the internal history needs to be trimmed to add the current command line, 
# setting this option will cause the oldest history 
# event that has a duplicate to be lost before losing a unique event from the list. 
setopt hist_expire_dups_first

# remove older duplicate entries from history
setopt hist_ignore_all_dups 
setopt hist_save_nodups 

# Remove command lines from the history list when the first character on the line is a space,
# or when one of the expanded aliases contains a leading space
setopt hist_ignore_space 

# Remove superfluous blanks from each command line being added to the history list.
setopt hist_reduce_blanks 

# Whenever the user enters a line with history expansion, don’t execute the line directly; 
# instead, perform history expansion and reload the line into the editing buffer.
setopt hist_verify
