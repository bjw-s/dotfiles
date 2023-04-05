#!/usr/bin/env bash

set -Eeuo pipefail

declare -r DOTFILES_REPO_URL="git@github.com:bjw-s/dotfiles.git"
declare -r CHEZMOI_TEMP_DIR="/tmp/bin"

function get_os_type() {
  uname
}

function initialize_macos() {
  function install_xcode() {
    local git_cmd_path="/Library/Developer/CommandLineTools/usr/bin/git"

    if [ ! -e "${git_cmd_path}" ]; then
      # Install command line developer tool
      xcode-select --install
      # Want for user input
      echo "Press any key when the installation has completed."
      IFS= read -r -n 1 -d ''
    else
      echo "Command line developer tools are already installed."
    fi
  }

  install_xcode
  export PATH="$PATH:/opt/homebrew/bin"
}

function initialize_os_env() {
  local ostype
  ostype="$(get_os_type)"

  if [ "${ostype}" == "Darwin" ]; then
    initialize_macos
  elif [ "${ostype}" == "Linux" ]; then
    initialize_linux
  else
    echo "Invalid OS type: ${ostype}" >&2
    exit 1
  fi
}

function initialize_dotfiles() {
  function run_chezmoi() {
    echo "Running chezmoi..."
    BINDIR="${CHEZMOI_TEMP_DIR}" sh -c "$(curl -fsLS get.chezmoi.io)"
    "${CHEZMOI_TEMP_DIR}/chezmoi" init "${DOTFILES_REPO_URL}"
    "${CHEZMOI_TEMP_DIR}/chezmoi" apply
  }

  function cleanup_chezmoi() {
    rm -rf "${CHEZMOI_TEMP_DIR}"
  }

  run_chezmoi
  cleanup_chezmoi
}

function main() {
  pushd ~ 2>&1 >/dev/null
  initialize_os_env
  initialize_dotfiles
  popd 2>&1 >/dev/null
}

main "$@"
