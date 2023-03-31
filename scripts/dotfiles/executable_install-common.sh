#!/bin/zsh
### Dotfiles (iam) project v1.0.0
### [Stan S](https://github.com/Jacke/-)
### Copyright 2020-2022
### <\*/>
set -euo pipefail
# ENV Variables
export NONINTERACTIVE=1
export NO_EDIT=1
export NO_TUTORIAL=1
export NO_INPUT=1

function exists() {
    command -v "$1" >/dev/null 2>&1
}
function fun-exists() {
  whence -w $1 >/dev/null
}

function fun-exists() { declare -F "$1" > /dev/null; }

function log() {
	printf "\033[33;34m %s: %s\n" "$(date -u)" "$1"
}

function get_keypress {
	local REPLY IFS=
	printf >/dev/tty '%s' "$*"
	[[ $ZSH_VERSION ]] && read -rk1 # Use -u0 to read from STDIN
	# See https://unix.stackexchange.com/q/383197/143394 regarding '\n' -> ''
	[[ $BASH_VERSION ]] && read </dev/tty -rn1
	printf '%s' "$REPLY"
}

function get_yes_keypress {
	local prompt="${1:-Are you sure [y/n]? }"
	local enter_return=$2
	local REPLY
	# [[ ! $prompt ]] && prompt="[y/n]? "
	while REPLY=$(get_keypress "$prompt"); do
		[[ $REPLY ]] && printf '\n' # $REPLY blank if user presses enter
		case "$REPLY" in
		Y | y) return 0 ;;
		N | n) return 1 ;;
		'') [[ $enter_return ]] && return "$enter_return" ;;
		esac
	done
}

function confirm {
	local prompt="${*:-Are you sure} [y/N]? "
	get_yes_keypress "$prompt" 1
}

function confirm_yes {
	local prompt="${*:-Are you sure} [Y/n]? "
	get_yes_keypress "$prompt" 0
}

function get_params() {
	if [[ "$DOCKER" -eq 1 ]]; then
		FNAME="Stephanie"
		LNAME="Holgate"
		EMAIL="StephanieHHolgate@teleworm.us"
		SIGNKEYID="F4DEF918475A5F3F"
		GITHUB_LOGIN="steph_hol"
		GITHUB_TOKEN=""
		EXTRA_PKGS="true"
		GPGSIGN="true"
		EXTRA_PLUGINS="true"
		SIGNKEYID2="AC28749A07E79FF0"
		EMAIL2=""
		COMPLETION=""
		GPGSIGN2="false"
	else
		read -p "Your first name : " FNAME
		read -p "Your last name : " LNAME
		read -p "Your email : " EMAIL
		read -p "GPG Key ID (optional) : " SIGNKEYID
		read -p "Shell Completion system (AUTOCOMPLETE or Default if empty) : " COMPLETION
		read -p "Github username (optional) : " GITHUB_LOGIN
		read -p "Github API Token (optional, you can set it later) : " GITHUB_TOKEN

		# Optional
		# Default value: [ -n "$newname" ] && name=$newname
		read -p "Additional GPG Key ID (optional) : " SIGNKEYID2
		read -p "Additional email (optional) : " EMAIL2

		get_yes_keypress "Do you wish to install extra-useful system packages [y/n]?" && EXTRA_PKGS="true" || EXTRA_PKGS="false"
		get_yes_keypress "Do you use GPG [y/n]?" && GPGSIGN="true" || GPGSIGN="false"
		get_yes_keypress "Do you use additinal GPG key [y/n]?" && GPGSIGN2="true" || GPGSIGN2="false"
		get_yes_keypress "Do you wish to install extra-useful zsh plugins [y/n]?" && EXTRA_PLUGINS="true" || EXTRA_PLUGINS="false"
	fi
}

function core_install() {
	if [[ $OSTYPE == 'darwin'* ]]; then
		DEV_PREFIX="Dev"
		SCRIPT_PREFIX="Scripts"
	else
		DEV_PREFIX="dev"
		SCRIPT_PREFIX="scripts"
	fi
	mkdir -p ~/$DEV_PREFIX
	cd ~/$DEV_PREFIX
	# ** Shell dependencies **
	if [[ "$DOCKER" -eq 1 ]]; then
		cp -r /dotfiles ~/$DEV_PREFIX/dotfiles
	else
		git clone https://github.com/Jacke/- ~/$DEV_PREFIX/dotfiles
	fi

	## ** Backup current shell settings **
	# TODO: backupCreate() to dotfiles/backup
	# cp .zshrc dotfiles/backup

	## * Init chezmoi & sync with ~/.dotfiles
	chezmoi init
	if [[ $OSTYPE == 'darwin'* ]]; then
		rm -rf ~/.local/share/chezmoi
	else
		rm -rf ~/.local/share/chezmoi
	fi
	ln -s ~/$DEV_PREFIX/dotfiles ~/.local/share/chezmoi
	cd ~/$DEV_PREFIX/dotfiles

	## ** Install params **
	echo "Please enter your details. You may add or change them later: "
	echo ""
	get_params
	# echo -e "Params: chezmoi init
	# 	--promptBool extra_pkgs=$EXTRA_PKGS
	# 	--promptBool gpgsign=$GPGSIGN
	# 	--promptBool gpgsign2=$GPGSIGN2
	# 	--promptBool extra_zsh_plugins=$EXTRA_PLUGINS
	# 	--promptString fname=$FNAME
	# 	--promptString lname=$LNAME
	# 	--promptString email=$EMAIL
	# 	--promptString signkey_id=$SIGNKEYID
	# 	--promptString prompt_completion=$COMPLETION
	# 	--promptString signkey_id2=$SIGNKEYID2
	# 	--promptString email2=$EMAIL2
	# 	--promptString github_login=$GITHUB_LOGIN
	# 	--promptString github_token=$GITHUB_TOKEN"
	echo "chezmoi init --promptBool extra_pkgs=$EXTRA_PKGS --promptBool gpgsign=$GPGSIGN --promptBool extra_zsh_plugins=$EXTRA_PLUGINS --promptString fname=$FNAME --promptString lname=$LNAME --promptString email=$EMAIL --promptString signkey_id=$SIGNKEYID --promptString signkey_id2=$SIGNKEYID2 --promptString email2=$EMAIL2 --promptString github_login=$GITHUB_LOGIN --promptString github_token=$GITHUB_TOKEN"
	chezmoi init \
		--promptBool extra_pkgs=$EXTRA_PKGS \
		--promptBool gpgsign=$GPGSIGN \
		--promptBool gpgsign2=$GPGSIGN2 \
		--promptBool extra_zsh_plugins=$EXTRA_PLUGINS \
		--promptString fname=$FNAME \
		--promptString lname=$LNAME \
		--promptString email=$EMAIL \
		--promptString prompt_completion=$COMPLETION \
		--promptString signkey_id=$SIGNKEYID \
		--promptString signkey_id2=$SIGNKEYID2 \
		--promptString email2=$EMAIL2 \
		--promptString github_login=$GITHUB_LOGIN \
		--promptString github_token=$GITHUB_TOKEN \
		/
	# ** Cleanup dotfiles git repo **
	rm -rf .git
	git init
	git remote add upstream https://github.com/Jacke/-

	# ** Apply shell settings **
	chezmoi apply

	## ** Install extra dependencies **
	## TODO: Decide what is the way of invoking the script: explicit or run_once

	## ** Restore backup shell configs **
	## TODO: Add backupRestore() from dotfiles/backup

	## ** Install Extensions **
	echo 'Install plugins...'
	/bin/zsh -i -c "echo 'Plugins have been installed'"
	/bin/zsh -c "zsh -i -c \"echo 'Start prompt...'\";exit"

	## ** Installation Summary **
	/bin/zsh -c "dotfiles-help installed"

	## ** Entrypoint **
	/bin/zsh
}
