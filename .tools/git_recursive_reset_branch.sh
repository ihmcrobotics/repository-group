#!/bin/bash

source "$(dirname "$0")/common_git_functions.sh"

git_recursive fetch --all --prune
git_recursive checkout develop
git_recursive reset --hard
git_recursive pull

git_recursive_delete_merged_branches

if [ "$1" != "develop" ]; then
  git_recursive checkout "$1"
  git_recursive reset --hard
  git_recursive pull
  git_recursive rebase develop
fi
