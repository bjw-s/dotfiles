#!/usr/bin/env bash

function is_fish_installed() {
  command -v fish > /dev/null
}

function is_fish_in_shells() {
  FISH=$(command -v fish)
  grep "${FISH}" /etc/shells > /dev/null
}

function is_fish_current_shell() {
  FISH=$(command -v fish)
  if [[ ${SHELL} == "${FISH}" ]]; then
    return 0
  fi
  return 1
}

function install_fish_shell() {
  if is_fish_installed; then
    if ! is_fish_in_shells; then
      FISH=$(command -v fish)
      echo "Need to add fish as a shell"
      echo "${FISH}" | sudo tee -a /etc/shells > /dev/null 2>&1
    fi

    if ! is_fish_current_shell; then
      FISH=$(command -v fish)
      echo "Changing shell to fish"
      chsh -s "${FISH}"
    fi
  fi
}

function is_fisher_installed() {
  test -f "${HOME}/.config/fish/functions/fisher.fish"
}

function install_fisher() {
  if ! is_fisher_installed; then
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish -o "${HOME}/.config/fish/functions/fisher.fish"
  fi
}

function main() {
  install_fish_shell
  install_fisher
}

if [[ ${#BASH_SOURCE[@]} = 1 ]]; then
  main
fi
