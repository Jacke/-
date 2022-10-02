#!/bin/zsh

#red=`tput setaf 1`
#green=`tput setaf 2`
#reset=`tput sgr0`
#echo "${red}red text ${green}green text${reset}"

# echo -e "\x1B[31m foobar \x1B[0m"
# echo -e "\x1B[32m foobar \x1B[0m"
# echo -e "\x1B[96m foobar \x1B[0m"
# echo -e "\x1B[01;96m foobar \x1B[0m"
# echo -e "\x1B[01;95m foobar \x1B[0m"
# echo -e "\x1B[01;94m foobar \x1B[0m"
# echo -e "\x1B[01;93m foobar \x1B[0m"
# echo -e "\x1B[01;91m foobar \x1B[0m"
# echo -e "\x1B[01;90m foobar \x1B[0m"
# echo -e "\x1B[01;89m foobar \x1B[0m"
# echo -e "\x1B[01;36m foobar \x1B[0m"

success_message() {
	echo -e "\x1B[32m****************************\x1B[0m"
	echo -e "\x1B[01;95m ~(iam) Dotfiles project has $1 \x1B[0m"
	echo -e "\x1B[32m****************************\x1B[0m"
}

main() {
	echo -e "\x1B[01;89mCommands: \x1B[0m"
	echo -e "\x1B[01;36m dotfiles-update\x1B[0m – update packages and dotfiles"
	echo -e "\x1B[01;36m dotfiles-uninstall\x1B[0m – uninstall dotfiles"
	echo -e "\x1B[32m****************************\x1B[0m"
	echo -e "\x1B[01;89mYou can adjust:\x1B[0m"
	echo -e "\x1B[01;36m Fonts\x1B[0m – \x1B[01;94mhttps://github.com/ryanoasis/nerd-fonts\x1B[0m"
	echo -e "\x1B[01;36m ~/.gitconfig\x1B[0m – git configuration"
	echo -e "\x1B[01;36m ~/.zshrc/plugins\x1B[0m – zsh plugins"
	echo -e "\x1B[01;36m ~/.path\x1B[0m – PATH variables"
	echo -e "\x1B[32m****************************\x1B[0m"
	echo -e "\x1B[01;89mHow to use Chezmoi:\x1B[0m"
	echo "\x1B[01;94mhttps://www.chezmoi.io/user-guide/command-overview/\x1B[0m"
}

if [[ "$1" = "installed" ]]; then
	success_message "installed"
	main
elif [[ "$1" = "updated" ]]; then
	success_message "updated"
	main
else
	main
fi
