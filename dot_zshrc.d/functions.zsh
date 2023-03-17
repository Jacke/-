####################################################################################################################################
##########################             Functions                    ################################################################
##########################      https://dotfiles.download           ################################################################
####################################################################################################################################
function autoload-executables-in-dir() {
  local autoload_dir="$1"
  fpath=("${autoload_dir}" "${fpath[@]}")
  # Autoload all shell functions from in a given directory that have
  # the executable bit set.  The executable bit is not necessary, but
  # gives you an easy way to stop the autoloading of a particular
  # shell function.
  for func in "${autoload_dir}"/*(N-.x:t); do
    autoload -Uz "$func";
  done
}
function source-if-exists() {
  [[ -e "$1" ]] && source "$1"
}
function source-in-dir() {
  local source_dir="$1"
  for func in "${source_dir}"/*; do
    source "$func";
  done
}

# Zsh file renaming using zmv
autoload zmv

# Setup function and completion directories.
autoload-executables-in-dir "$HOME/.zshrc.d/functions"
source-in-dir "$HOME/.zshrc.d/functions/collections"
source-if-exists "${ZSH_WORK_DOTFILES}/work-env.zsh"
source-if-exists "${ZSH_WORK_DOTFILES}/host-env.zsh"
