# Repository Group Template

### Purpose

These Gradle files serve as a "glue" for your IHMC projects. Use it to perform Gradle operations on many projects at once, such as "Import" into an IDE.

These files are compatible with projects that use the [ihmc-build](https://github.com/ihmcrobotics/ihmc-build) plugin, however, you may clone non-ihmc-build repositories into this group, you will just need to import them into your IDE seperately, and they will not be included in the main build.

### Starting from scratch

Use [repository-collections](https://github.com/ihmcrobotics/repository-collections) or build the repo structure manually:

- `git clone` this repository.
- `cd repository-group`
- `git clone` project repositories into it.

Normally, nesting Git repos inside each other is frowned upon, but in this case, the .gitignore uses a whitelist instead of a blacklist, so your repos won't be affected by Git operations on repository-group.

### Maintaining the workspace

We provide recursive git scripts in the `.tools` directory to help keep your group up to date.

```
# Perform Git operation on all repos including this one
repository-group $ .tools/git_recursive.sh [git args ...]

# Delete local branches after the PR has been merged.
repository-group $ .tools/git_recursive_delete_merged_branches.sh

# Reset to a branch and rebase it with develop.
# WARNING: Discard local changes first!
# This checks out develop, pulls, fetches,
# checks out, and rebases your branch onto develop.
repository-group $ .tools/git_recursive_reset_branch.sh branch-name

# Examples:

# Fetch all repos 
repository-group $ .tools/git_recursive.sh fetch --all

# Start working on your feature and make sure you're up to date with develop
repository-group $ .tools/git_recursive_reset_branch.sh feature/improvements
```

### Convert your existing folder to a repository-group

If you already have some repositories cloned, you can initialize this repository over it.

```
cd /path/to/existing-group
git init
git remote add origin https://github.com/ihmcrobotics/repository-group.git
git fetch
git checkout -b develop
git reset origin/develop --hard
git branch --set-upstream-to origin/develop develop
```

### Cleaning up build files

Run `gradle cleanBuild --console=plain` to clean all `build/` (Gradle), `bin/` (Eclipse IDE), and `out/` (IntelliJ IDE) build directories.

This sometimes helps to forces IDEs to recompile the code when state becomes inconsistent.

### Gradle install scripts

This repo contains helper scripts (in the `.tools` directory) to install Gradle system-wide. There are installation scripts for both Linux (Ubuntu) and Windows.

**Linux usage:**
```
cd repository-group/.tools
sudo bash installGradle-<version>.sh
```
**Windows usage:**<br>
Open a file explorer to the repository-group/tools directory. Right click on `installGradle-<version>.bat` and click `Run as administrator`.

### Support

Support is provided through Github issues.

Duncan Calvert (dcalvert@ihmc.org)
Dexton Anderson (danderson@ihmc.org)
