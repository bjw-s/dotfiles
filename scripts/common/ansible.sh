#!/usr/bin/env bash

set -euoE pipefail

# shellcheck disable=SC2086
cwd="$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)"
ansible_folder="${cwd}/../../ansible"
export ANSIBLE_CONFIG="${ansible_folder}/ansible.cfg"

sudo_required() { sudo -n true 2>/dev/null || return 0; }

display_help() {
  echo "Usage: ./ansible.sh [arguments]..."
  echo
  echo "  --install           install deps for ansible"
  echo "  --run               run ansible playbook"
  echo "  --all               install deps and run the playbook"
  echo "  -h, --help          display this help message"
  echo
}

install_requirements() {
  echo "⚪ [ansible] installing requirements..."
  ansible-galaxy install -r "${ansible_folder}/requirements.yaml"
}

check_playbook() {
  echo "⚪ [ansible] checking playbook..."
  local playbook_opts=()

  if sudo_required; then
    playbook_opts+=("--ask-become-pass")
  fi

  ansible-playbook -e "ansible_user=$(whoami)" "${ansible_folder}/main.yaml" -v "${playbook_opts[*]}" --check
}

run_playbook() {
  echo "⚪ [ansible] running playbook..."
  local playbook_opts=()

  if sudo_required; then
    playbook_opts+=("--ask-become-pass")
  fi

  echo "ansible-playbook -e \"ansible_user=$(whoami)\" \"${ansible_folder}/main.yaml\" -v \"${playbook_opts[*]}\""
  ansible-playbook -e "ansible_user=$(whoami)" "${ansible_folder}/main.yaml" -v "${playbook_opts[*]}"
  echo "✅ [ansible] configured!"
}

# process arguments
while [[ $# -gt 0 ]]; do
  arg=$1
  case $arg in
    -h | --help)
      display_help
      exit 0
      ;;
    --install)
      install_requirements
      ;;
    --check)
      check_playbook
      ;;
    --run)
      run_playbook
      ;;
    --all)
      install_requirements
      run_playbook
      ;;
    *)
      exit_help "Unknown argument: $arg"
      ;;
  esac
  shift
done
