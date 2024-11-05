# Function to check if a directory is a Git repository
is_git_repo() {
  git -C "$1" rev-parse --is-inside-work-tree &>/dev/null
}

git_nested() {
  search_dir="$1"

  echo -e "=== Running ${@:2} ===";
  
  # Find all .git directories and run the command in their parent directories
  find "$search_dir" -type d -name ".git" | while read -r git_dir; do
    repo_dir=$(dirname "$git_dir")

    remote_url_string=$(git -C "$repo_dir" remote show origin | grep Fetch);
    
    # Check if the string does NOT contain "repository-group"
    echo $remote_url_string | grep -q "repository-group"
    not_repository_group=$?
    
    # If grep finds the string, it will return 0. So we check if it's not equal to 0
    if is_git_repo "$repo_dir" && [ $not_repository_group -ne 0 ]; then
      echo $repo_dir:
      git -C "$repo_dir" ${@:2}
    fi
  done
}

git_nested_delete_merged_branches() {
  search_dir="$1"

  echo -e "=== Removing merged branches ===";
  
  # Find all .git directories and run the command in their parent directories
  find "$search_dir" -type d -name ".git" | while read -r git_dir; do
    repo_dir=$(dirname "$git_dir")

    remote_url_string=$(git -C "$repo_dir" remote show origin | grep Fetch);
    
    # Check if the string does NOT contain "repository-group"
    echo $remote_url_string | grep -q "repository-group"
    not_repository_group=$?
    
    # If grep finds the string, it will return 0. So we check if it's not equal to 0
    if is_git_repo "$repo_dir" && [ $not_repository_group -ne 0 ]; then
      echo $repo_dir:
      git -C "$repo_dir" for-each-ref --format '%(refname:short) %(upstream:track)' | awk '$2 == "[gone]" {print $1}' | xargs -r git -C $repo_dir branch -D
    fi
  done
}

