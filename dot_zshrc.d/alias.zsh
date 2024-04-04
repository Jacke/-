####################################################################################################################################
##########################            Aliases                 ######################################################################
##########################      https://dotfiles.download     ######################################################################
####################################################################################################################################
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
####################################################
# General                                          #
####################################################
alias bat='bat --color=always --theme=ansi'
[ -f /usr/local/bin/ccat ] && alias cat="/usr/local/bin/ccat"
alias hhistory="fc -rl 1 | fzf"
alias j=z
# alias ls="lsd --icon=never"
alias ls="exa --no-icons"
alias myip="curl https://ipinfo.io/ip"
alias pp='pbpaste >'
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias re-run="fc -e nano -1"
alias virc='vi ~/.zshrc' sorc='source ~/.zshrc'
alias zshconfig="${EDITOR} ~/.zshrc"
alias dus='dust -pr -d 2 -X ".git" -X "node_modules"'
alias ll='exa -alhF --group-directories-first --time-style=long-iso'
alias psa='ps aux' pskl='psa | fzf | awk "{ print \$2 }" | xargs kill -9'
alias fd='fd -iH --no-ignore-vcs -E ".git" -E "node_modules"' rmds='fd .DS_Store -X rm'
alias rg='rg --hidden -g "!.git" -g "!node_modules" --max-columns 200' rgi='rg -i' rgn='rgi --no-ignore'
alias llx='ll --git-ignore --ignore-glob=".git|node_modules"' tr2='llx -T -L=2' tr3='llx -T -L=3'
catp() { cat "$1" | pbcopy }
rgsd() { rg -l "$1" | xargs sd "$1" "$2"; }
fdsd() { fd "$1" -x rename "s/${2}/${3}/ if -f" }
absp() { echo $(cd $(dirname "$1") && pwd -P)/$(basename "$1"); }
alias shfmt="shfmt -i 2 -bn -ci -sr -l -w"
## ========== Global Alias ==========
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g X='| xargs'
alias -g C='| wc -l'
alias -g CP='| pbcopy'
## ========== Suffix Alias ==========
alias -s {png,jpg,jpeg}='imgcat'
alias -s {html,mp3,mp4,mov}='open'
### ========== Mac OS X =========
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
## ========== Reload ===========
alias rz='reload-zshrc'
alias rf='reload-function'
alias rfr='reload-function-and-run'
alias reloadshell="source $HOME/.zshrc"
####################################################
# Git                                              #
# ~/.gitconfig has more                            #
####################################################
#alias g='git' && compdef _git g

# Alias to create a new branch or switch to an existing branch
alias gco='git checkout'
alias gcb='function _gcb(){ git checkout -b $1 || git checkout $1; }; _gcb'

# Alias to switch to the master branch
alias gcm='git checkout master'

# Alias for pulling with rebase from the master branch
alias gprm='git pull origin master --rebase'

# Alias for rebasing the current branch on top of the master branch
alias grbm='git rebase master'

alias cdgh='cd `ghq list -p | fzf`'
alias cdg='cd `git rev-parse --show-toplevel`'
gcre() {
  [ -z "$(ls -A ./)" ] && echo "Fail: Directory is empty." && return 0;
  git init;
  git secrets --install && git secrets --register-aws;
  git add -A && git commit;
  read        name"?type repo name        : ";
  read description"?type repo description : ";
  gh repo create ${name} --description ${description} --private;
  git push --set-upstream origin master;
  gh repo view --web;
}
combine-branches() {
  g co develop; 
  g branch -D COMBINED_$(whoami); 
  g co -b COMBINED_$(whoami); 
  g cherry-pick $1; 
  g cherry-pick $2;
} 
combine-branches-back() {
  combine-branches();
  g co $3;
}
alias git_branch_clean_up= 'git branch --merged | grep -v \* | xargs git branch -d'
####################################################
# Services & Tools                                 #
####################################################
weather() { curl v2.wttr.in/$1 }
alias haha='say -v Anna "haha"'
alias btc_price="curl rate.sx/btc"
alias hf='hyperfine --max-runs 3'
alias ydl='youtube-dl -x --audio-format mp3'
####################################################
# Develop                                          #
####################################################
alias sbr="sbt run"
alias todo=/usr/local/Cellar/node/14.3.0/lib/node_modules/leasot/bin/leasot
alias ggovm="$GOPATH/bin/g"; # g-install: do NOT edit, see https://github.com/stefanmaric/g
vv() {
  [ -z "$1" ] && code -r ./ && return 0;
  code -r "$1";
}
alias k6run='k6 run --vus 10 --duration 40s'
lnsv() {
  [ -z "$2" ] && echo "Specify Target" && return 0;
  abspath=$(absp $1);
  ln -sfnv "${abspath}" "$2";
}
rgvi() {
  [ -z "$2" ] && matches=`rg "$1" -l`;
  [ -z "${matches}" ] && echo "no matches\n" && return 0;
  selected=`echo "${matches}" | fzf --preview "rg -pn '$1' {}"`;
  [ -z "${selected}" ] && echo "fzf Canceled." && return 0;
  vi "${selected}";
}
fdvi() {
  [ -z "$2" ] && matches=`fd "$1"`;
  [ -z "${matches}" ] && echo "no matches\n" && return 0;
  selected=`echo "${matches}" | fzf --preview "bat --color=always {}"`;
  [ -z "${selected}" ] && echo "fzf Canceled." && return 0;
  vi "${selected}";
}
hst() {
  cmd=`history 1 | awk '{$1="";print $0;}' | fzf`
  [ -z "${cmd}" ] && echo "fzf Canceled." && return 0;
  echo "${cmd}" && eval "${cmd}"
}
cimg() {
  case "$1" in
    *.jpeg|*.jpg) opt="--mozjpeg";;
    *.png)        opt="--oxipng";;
  esac
  squoosh-cli "$opt" '{}' "$1"
}
####################################################
# iTerm2                                           #
####################################################
alias test_label="tc e91e63"
alias prod_label="tc 76ff03"
test_label_connect() { tc e91e63 && et $1 }
prod_label_connect() { tc 76ff03 && et $1 }
eeg_label_connect() { tc ffff00 && et $1 }
####################################################
# tmux                                             #
# Extracted from tmux plugin@oh-my-zsh             #
####################################################
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Help command
unalias run-help &> /dev/null
autoload run-help
[ -d /usr/share/zsh/help ] && HELPDIR=/usr/share/zsh/help
[ -d /usr/local/share/zsh/help ] && HELPDIR=/usr/local/share/zsh/help
alias help=run-help



## Git

alias branch='show_git_branch'

# Alias to create a new branch or switch to an existing branch
alias gco='git checkout'
alias gcb='function _gcb(){ git checkout -b $1 || git checkout $1; }; _gcb'

# Alias to switch to the master branch
alias gcm='git checkout master'

# Alias for pulling with rebase from the master branch
alias gprm='git pull origin master --rebase'

# Alias for rebasing the current branch on top of the master branch
alias grbm='git rebase master'


