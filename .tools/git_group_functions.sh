# Function to check if a directory is a Git repository
is_git_repo() {
  git -C "$1" rev-parse --is-inside-work-tree &>/dev/null
}

recursive_git() {
  repo_dirs=($(find "$(pwd)" -type d -name ".git" -exec dirname {} \;))
  repo_dirs=($(for i in "${repo_dirs[@]}"; do echo "$i"; done | sort))

  for repo_dir in "${repo_dirs[@]}"; do
    if is_git_repo "$repo_dir"; then
      relative_repo_dir=$(realpath --relative-to="$(pwd)" "$repo_dir")
      echo "git -C $relative_repo_dir ${@:1}"
      git -C "$relative_repo_dir" ${@:1}
    fi
  done
}

# Not sure how to share the common code between these two
recursive_git_delete_merged_branches() {
  repo_dirs=($(find "$(pwd)" -type d -name ".git" -exec dirname {} \;))
  repo_dirs=($(for i in "${repo_dirs[@]}"; do echo "$i"; done | sort))

  for repo_dir in "${repo_dirs[@]}"; do
    if is_git_repo "$repo_dir"; then
      relative_repo_dir=$(realpath --relative-to="$(pwd)" "$repo_dir")
      echo "git -C $relative_repo_dir for-each-ref --format '%(refname:short) %(upstream:track)' | awk '\$2 == "[gone]" {print \$1}' | xargs -r git -C $repo_dir branch -D"
      git -C "$relative_repo_dir" for-each-ref --format '%(refname:short) %(upstream:track)' | awk '$2 == "[gone]" {print $1}' | xargs -r git -C $repo_dir branch -D
    fi
  done
}

