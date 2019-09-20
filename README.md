# Repository Group Template

### Purpose

These Gradle files serve as a "glue" for your IHMC projects. Use it to perform Gradle operations on many projects at once, such as "Import" into an IDE.

These files are compatible with projects that use the [ihmc-build](https://github.com/ihmcrobotics/ihmc-build) plugin, however, you may clone non-ihmc-build repositories into this group, you will just need to import them into your IDE seperately, and they will not be included in the main build.

### Starting from scratch

- `git clone` this repository.
- `cd repository-group`
- `git clone` project repositories into it.

Normally, nesting Git repos inside of each other is frowned upon, but in this case, the .gitignore uses a whitelist instead of a blacklist, so your repos won't be affected by Git operations on repository-group.

### Convert your existing folder to a repository-group

If you already have some repositories cloned, you can initialize this repository over it.

```
cd /path/to/existing-group
git init
git remote add origin https://yourusername@stash.ihmc.us/scm/rob/repository-group.git
git fetch
git reset origin/develop --hard
git branch --set-upstream-to origin/develop develop
```

### Staying up to date

`git pull` to update to the latest ihmc-build plugin.

### Cleaning up build files

Run `gradle cleanBuild --console=plain` to clean all `build/` (Gradle), `bin/` (Eclipse IDE), and `out/` (IntelliJ IDE) build directories.

This sometimes helps to forces IDEs to recompile the code when state becomes inconsistent.

### Support

Support is provided through Github issues.

Duncan Calvert (dcalvert@ihmc.us)

**This repo is read-only. Do not attempt to push your changes!**
