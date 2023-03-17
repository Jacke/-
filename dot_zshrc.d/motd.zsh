####################################################################################################################################
##########################               MOTD                       ################################################################
##########################      https://dotfiles.download           ################################################################
####################################################################################################################################
## TODO:
## Add ability to set motd app for system // directory
## option to set frequency (system/dir)
## alias and key binding 
if exists $MOTD; then
  if [[ -r "$HOME/Scripts/bin/cache_out" ]]; then
    eval "cache_out $MOTD" # Faster shell startup
  else
    eval "$MOTD $MOTD_PARAMS"
  fi
fi
