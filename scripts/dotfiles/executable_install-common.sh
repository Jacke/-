#!/bin/bash
### Dotfiles (iam) project v1.0.0
### [Stan S](https://github.com/Jacke/-)
### Copyright 2020-2022
### <\*/>

# ENV Variables
export NONINTERACTIVE=1
export NO_EDIT=1
export NO_TUTORIAL=1
export NO_INPUT=1

function exist() {
	command -v "$1" >/dev/null 2>&1
}

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
		FULL_PKG="true"
		GPGSIGN="true"
		FULL_PLUGINS="true"
		SIGNKEYID2="AC28749A07E79FF0"
		EMAIL2=""
	else
		read -p "Your first name : " FNAME
		read -p "Your last name : " LNAME
		read -p "Your email : " EMAIL
		read -p "GPG Key ID (optional) : " SIGNKEYID
		read -p "Github username (optional) : " GITHUB_LOGIN
		read -p "Github API Token (optional, you can set it later) : " GITHUB_TOKEN

		# Optional
		# Default value: [ -n "$newname" ] && name=$newname
		read -p "Additional GPG Key ID (optional) : " SIGNKEYID2
		read -p "Additional email (optional) : " EMAIL2

		get_yes_keypress "Do you wish to install extra-useful system packages [y/n]?" && FULL_PKG="true" || FULL_PKG="false"
		get_yes_keypress "Do you use GPG [y/n]?" && GPGSIGN="true" || GPGSIGN="false"
		get_yes_keypress "Do you wish to install extra-useful zsh plugins [y/n]?" && FULL_PLUGINS="true" || FULL_PLUGINS="false"
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
	git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
	if [[ "$DOCKER" -eq 1 ]]; then
		mv /dotfiles ~/$DEV_PREFIX/dotfiles
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
	cd ~/.local/share/chezmoi

	## ** Install arguments **
	get_params

	chezmoi init \
		--promptBool full=$FULL_PKG \
		--promptBool gpgsign=$GPGSIGN \
		--promptBool extra_zsh_plugins=$FULL_PLUGINS \
		--promptString fname=$FNAME \
		--promptString lname=$LNAME \
		--promptString email=$EMAIL \
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

	## ** Installation Summary **
	# dotfiles-help installed
	/bin/zsh -i -c "~/scripts/dotfiles/help.zsh installed"

	## ** Install extra dependencies **
	## TODO: Decide what is the way of invoking the script: explicit or run_once

	## ** Restore backup shell configs **
	## TODO: Add backupRestore() from dotfiles/backup

	## ** Entrypoint **
	exec zsh
}

function initParams() {
	# Get install params (dir, extras packages, config parameters)
	while [[ "$#" -gt 0 ]]; do
		case $1 in
		-d | --dir)
			target="$2"
			shift
			;;
		-c | --conf)
			config="$2"
			shift
			;; # parse config params as <k|v>
		-m | --full) full=1 ;;
		*)
			echo "Unknown parameter passed: $1"
			exit 1
			;;
		esac
		shift
	done

	echo "Where to install: $target"
	echo "Should add all extra packages  : $full"
	echo "Config parameters : $config"
}
