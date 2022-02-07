#!/usr/bin/env bash

# Root folders to search
SRC_FOLDER="$HOME/Development/src"

declare -a PROJECTS=()
ROOT_FOLDER="$(cd "$SRC_FOLDER" && pwd -P)"

all_my_projects(){
  # Gather Git projects
  git_projects=()
  while IFS='' read -r line; do git_projects+=("$line"); done < <(find "${ROOT_FOLDER}" -type d -name ".git" -printf '%h\n')

  for git_project in "${git_projects[@]}"
  do
    PROJECTS+=("${git_project#"${ROOT_FOLDER}/"}")
  done

  printf "%s\n" "${PROJECTS[@]}"
}

if [ -z "$1" ]; then
  all_my_projects
else
  code "$ROOT_FOLDER/$1" > /dev/null 2>&1 &
fi
