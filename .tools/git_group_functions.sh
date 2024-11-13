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
