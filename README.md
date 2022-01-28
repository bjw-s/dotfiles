# Dotfiles

My dotfiles managed by chezmoi

## Prerequisites

### macOS

Update macOS and Install Xcode command line tools.

```sh
sudo softwareupdate -i -a
xcode-select --install
```

## Installation

Install [chezmoi](https://www.chezmoi.io/docs/install/#one-line-package-install).

## Initizalize chezmoi

```sh
chezmoi --source ~/Development/source_code/git/github.com/bjw-s/dotfiles init https://github.com/bjw-s/dotfiles.git
```

## Deploy dotfiles

```sh
chezmoi apply
```
