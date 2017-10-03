# Repository Group Template

### Purpose

Allows you to import all cloned code at once.

### Creating a new group

Clone this repo, then clone project repositories into it. They will be gitignored. Nesting is not a problem.

### Convert an existing project group

cd /path/to/existing-group
git init
git remote add origin https://yourusername@stash.ihmc.us/scm/rob/repository-group.git
git fetch
git reset origin/master --hard

### Keeping files up to date

Pull to update to the latest ihmc-build plugin.

### Warning

This repo is read-only. Do not attempt to push your changes!

### Support

@ mention on IHMC Slack #help-desk! 

Duncan Calvert (dcalvert@ihmc.us)
