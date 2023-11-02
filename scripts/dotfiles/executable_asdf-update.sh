#!/bin/bash

# Path to ASDF .tool-versions file
TOOL_VERSIONS_FILE=~/.tool-versions

# Get list of all plugins (languages)
PLUGINS=$(asdf plugin-list)

# Check if gsed is installed (on Mac)
if [[ $(command -v gsed) ]]; then
  SED="gsed"
else
  SED="sed"
fi

# Loop through each plugin
for plugin in $PLUGINS; do
  # Get latest stable version
  latest_version=$(asdf latest "${plugin}")
  echo "${plugin} ${latest_version}"
  # Update tool versions file for this plugin
  $SED -i "/${plugin}/c\\${plugin} ${latest_version}" "$TOOL_VERSIONS_FILE"
done

asdf install
