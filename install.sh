#!/usr/bin/env bash

set -e # -e: exit on error

function is_brew_installed() {
  command -v brew > /dev/null
}

function is_asdf_installed() {
  command -v asdf > /dev/null
}

function is_chezmoi_installed() {
  command -v chezmoi > /dev/null
}

function install_asdf_plugin() {
  asdf plugin add "$1"
  asdf install "$1" latest
  asdf global "$1" latest
}

function apply_dotfiles() {
  chezmoi=$(command -v chezmoi)
  script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
  "${chezmoi}" init --apply "--source=${script_dir}"
}

function main() {
  if ! is_brew_installed ; then
    echo "Error! brew is not installed"
    echo "Visit https://brew.sh to get started"
    exit 1
  fi

  if ! is_asdf_installed ; then
    echo "Error! asdf is not installed"
    echo "Visit https://asdf-vm.com/guide/getting-started.html to get started"
    exit 1
  fi

  if ! is_chezmoi_installed ; then
    install_asdf_plugin "chezmoi"
  fi
  apply_dotfiles
}

if [[ ${#BASH_SOURCE[@]} = 1 ]]; then
  main
fi
