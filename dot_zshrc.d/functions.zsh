####################################################################################################################################
##########################             Functions                    ################################################################
##########################      https://dotfiles.download           ################################################################
####################################################################################################################################
# zsh file renaming using zmv
autoload zmv

# Setup function and completion directories.
autoload-executables-in-dir "$HOME/.zshrc.d/functions"
source-if-exists "${ZSH_WORK_DOTFILES}/work-env.zsh"
source-if-exists "${ZSH_WORK_DOTFILES}/host-env.zsh"
