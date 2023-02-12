# FAQ

## Common problems

### Completions

```
compinit:503: no such file or directory: /Users/John/.local/share/zinit/completions/_afew
compinit:503: no such file or directory: /Users/John/.local/share/zinit/completions/_android
compinit:shift:505: shift count must be <= $#
compinit:503: no such file or directory: /Users/John/.local/share/zinit/completions/_archlinux-java
```

**Solution**
```
# dotfiles-reinit-completions

zinit cclear
zinit creinstall zsh-users/zsh-completions
```


### Bug with multilines (iTerm2 Mac OS)

**Solution**
Reinstall iTerm2

## How to measure speed?

**Solution**
```
PS4='+%D{%s.%9.}:%N:%i>' zsh -x
<trace awk -F: '{printf "+%.09f", $1 - t; t=$1; $1=""; print}'
```
