#!/bin/bash

source "$(dirname "$0")/git_group_functions.sh"
recursive_git_delete_merged_branches
