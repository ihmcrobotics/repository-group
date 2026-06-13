#!/bin/bash

source "$(dirname "$0")/common_git_functions.sh"

git_recursive fetch --all --prune
git_recursive checkout _default_
git_recursive reset --hard
git_recursive pull

git_recursive_delete_merged_branches

if [ -n "$1" ]; then
  git_recursive checkout "$1"
  git_recursive reset --hard
  git_recursive pull
  git_recursive rebase _default_
fi
