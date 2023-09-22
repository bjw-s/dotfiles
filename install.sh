#!/usr/bin/env bash

set -e # -e: exit on error

function is_brew_installed() {
  command -v brew > /dev/null
}

function is_rtx_installed() {
  command -v rtx > /dev/null
}

function is_chezmoi_installed() {
  command -v chezmoi > /dev/null
}

function install_rtx_plugin() {
  rtx plugin add "$1"
  rtx install "${1}@latest"
  rtx global "${1}@latest"
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

  if ! is_rtx_installed ; then
    echo "Error! rtx is not installed"
    echo "Visit https://github.com/jdx/rtx#installation to get started"
    exit 1
  fi

  if ! is_chezmoi_installed ; then
    install_rtx_plugin "chezmoi"
  fi
  apply_dotfiles
}

if [[ ${#BASH_SOURCE[@]} = 1 ]]; then
  main
fi
