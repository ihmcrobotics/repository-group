#!/bin/bash

source "$(dirname "$0")/common_git_functions.sh"
git_recursive_delete_merged_branches
