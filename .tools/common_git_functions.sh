# Function to check if a directory is a Git repository
is_git_repo() {
  git -C "$1" rev-parse --is-inside-work-tree &>/dev/null
}

find_repo_dirs() {
  # 1. Recursively find .git folders.
  # 2. Remove the /.git from path.
  # 3. Make the path relative.
  # 4. Sort paths alphabetically.
  find "$(pwd)" -type d -name ".git" -print0 \
  | xargs -0 -I {} dirname {} \
  | xargs -I {} realpath --relative-to="$(pwd)" {} \
  | sort
}

# Recursively runs git commands on all git repos in a directory
git_recursive() {
  mapfile -t repo_dirs < <(find_repo_dirs)

  for repo_dir in "${repo_dirs[@]}"; do
    if is_git_repo "$repo_dir"; then
      echo "git -C \"$repo_dir\" $*"
      git -C "$repo_dir" "$@"
    fi
  done
}

# Deletes branches that used to have a matching ref on the remote, but it has
# been deleted. This happens when PRs are merged.
# (Not sure how to share the common code with the above)
git_recursive_delete_merged_branches() {
  mapfile -t repo_dirs < <(find_repo_dirs)

  for repo_dir in "${repo_dirs[@]}"; do
    if is_git_repo "$repo_dir"; then
      echo "git -C \"$repo_dir\" for-each-ref --format '%(refname:short) %(upstream:track)' | awk '\$2 == "[gone]" {print \$1}' | xargs -r git -C \"$repo_dir\" branch -D"
      git -C "$repo_dir" for-each-ref --format '%(refname:short) %(upstream:track)' | awk '$2 == "[gone]" {print $1}' | xargs -r git -C "$repo_dir" branch -D
    fi
  done
}

