#!/bin/zsh

export DOCKER=1
SCRIPT_DIR=$(dirname "$0")
INSTALL_DIR=$SCRIPT_DIR/../scripts/dotfiles
export INSTALL_COMMON=$INSTALL_DIR/executable_install-common.sh

chmod +x $INSTALL_DIR/executable_install-linux.sh
$INSTALL_DIR/executable_install-linux.sh
# . scripts/dotfiles/executable_install-linux.sh

