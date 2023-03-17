# ~ Dotfiles

<p align="center">
  <img width="63%" src="./pics/logo.png">
</p>

## Run

```shell
source <(curl -sL dotfiles.download/install)
```

## Benefits

This project is collection of incredible experience for terminal users.
Yes. This is for you! You are:

* Innovators
* Minimalism lovers with wise taste
* Fans of exceptional user experience

## Content

Project consists installer-configuration manager – **Serotonin**.
Whole project has agile structure with meaningful entities.

### Tree and Description

#### Root

```shell
├── Brewfile
├── dot_zprofile
├── dot_zshenv
├── dot_zshrc
└── install
```

<details>
  <summary>Root directory</summary>


| Filename     | Description |
| ---          | ---       |
| .zshenv      | it contains exported variables that should be available to other programs. For example, $PATH, $EDITOR, and $PAGER are often set in .zshenv. Also, you can set $ZDOTDIR in .zshenv to specify an alternative location for the rest of your zsh configuration.        |
| .zprofile    | .zprofile is basically the same as .zlogin except that it's sourced before .zshrc while .zlogin is sourced after .zshrc. According to the zsh documentation, ".zprofile is meant as an alternative to .zlogin for ksh fans; the two are not intended to be used together, although this could certainly be done if desired."        |
| .zshrc       | it is for interactive shell configuration. You set options for the interactive shell there with the setopt and unsetopt commands. You can also load shell modules, set your history options, change your prompt, set up zle and completion, et cetera. You also set any variables that are only used in the interactive shell (e.g. $LS_COLORS). |
| install      | Global install script. It's using **Serotonin** |
</details>

#### zshrc.d

```shell
├── dot_zshrc.d
│   ├── functions
│   ├── alias.zsh
│   ├── colors.zsh
│   ├── completions.zsh
│   ├── functions.zsh
│   ├── history.zsh
│   ├── keybindings.zsh
│   ├── options.zsh
│   ├── plugins.zsh
│   ├── prompt.zsh
│   └── terminal.zsh
```
<details>
  <summary>zshrc.d directory</summary>

| Filename     | Description |
| ---          | ---       |
| Backtick     | ..        |
| Pipe         | ..        |
</details>

#### Scripts

```shell
├── scripts
│   ├── sync
│   │   ├── copy_vscode.sh
│   │   ├── init_chezmoi.sh
│   │   ├── sync_app_settings
│   │   ├── sync_brew
│   │   ├── sync_npm
│   │   ├── sync_pip
│   │   ├── sync_snippets_cheat
│   │   └── wapm.lock
│   ├── gate
│   ├── install_linux.sh
│   ├── learn.zsh
│   ├── run_once_install-packages.sh.tmpl
│   ├── uninstall.sh
│   ├── update.zsh
│   └── upsert_cheatsheets.sh
```
<details>
  <summary>Scripts directory</summary>

| Filename     | Description |
| ---          | ---       |
| Backtick     | ..        |
| Pipe         | ..        |
</details>

#### vscode

```shell
├── vscode
│   ├── snippets
│   │   └── scala.json
│   ├── keybindings.json
│   └── settings.json
```
<details>
  <summary>VSCode directory</summary>

| Filename     | Description |
| ---          | ---       |
| Backtick     | ..        |
| Pipe         | ..        |
</details>

## Perfomance

Shell launch time:

🐢 Top rated dotfile  
TBA

🥇 ~ (iam)

TBA

Full bench – TBA

## TODO

[Project Board](https://github.com/users/Jacke/projects/1)

## Contribute

You can help this project by contribution to issue, donate to project
[Contribute Guide](./CONTRIBUTE.md)

## Changelog

[Changelog](./CHANGELOG.md)

## License

[MIT License](./LICENSE)
