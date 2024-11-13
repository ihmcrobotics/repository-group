#!/bin/bash

source "$(dirname "$0")/git_group_functions.sh"

recursive_git fetch --all --prune
recursive_git checkout develop
recursive_git reset --hard
recursive_git pull
recursive_git fetch --all --prune

recursive_git_delete_merged_branches

if [ "$1" != "develop" ]; then
  recursive_git checkout $1
  recursive_git reset --hard
  recursive_git pull
  recursive_git rebase develop
fi
