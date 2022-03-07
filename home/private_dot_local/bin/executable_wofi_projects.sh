#!/usr/bin/env bash

# Root folders to search
SRC_FOLDER="$HOME/Development/src"

declare -a PROJECTS=()
ROOT_FOLDER="$(cd "$SRC_FOLDER" && pwd -P)"

all_projects(){
  # Gather Git projects
  max_depth=7
  git_projects=()
  while IFS='' read -r line; do git_projects+=("$line"); done < <(find "${ROOT_FOLDER}" -maxdepth "${max_depth}" -type d -name ".git" -printf '%h\n')

  for git_project in "${git_projects[@]}"
  do
    PROJECTS+=("${git_project#"${ROOT_FOLDER}/"}")
  done

  # Gather SVN projects
  max_depth=7
  svn_projects=()
  while IFS='' read -r line; do svn_projects+=("$line"); done < <(find "${ROOT_FOLDER}" -maxdepth "${max_depth}" -type d -name ".svn" -printf '%h\n')

  for svn_project in "${svn_projects[@]}"
  do
    PROJECTS+=("${svn_project#"${ROOT_FOLDER}/"}")
  done

  printf "%s\n" "${PROJECTS[@]}"
}

all_projects | wofi --show dmenu --prompt="Select a project" | {
  read -r project name
  /usr/bin/fish -i -c "code "$ROOT_FOLDER/$project" > /dev/null 2>&1 &"
}
sleep 1
swaymsg [class="Code"] focus
