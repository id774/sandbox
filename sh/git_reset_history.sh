#!/bin/sh
# git_reset_history.sh: Destructively replace a repository's history with one commit
#
# Description:
# Reset the commit history of a Git repository to a single Initial commit,
# keeping the working tree and the remote repository itself.
#
# WARNING: this rewrites and discards history. Run it only against a
# disposable repository whose history may be discarded. It:
# - replaces the history of the local master branch with one new root commit
#   named Initial commit, built with git add -A from every file in the
#   working tree, including untracked files that are not ignored;
# - replaces origin/master with that commit through git push
#   --force-with-lease, guarded by the origin/master SHA read at the start;
# - deletes every tag from origin, then every local tag;
# - expires the whole reflog and runs git gc --prune=now --aggressive, so the
#   old commits are dropped from the local object store.
# Before rewriting, it saves every ref in ../repository-before-rewrite.bundle,
# a path relative to the current directory, and verifies that bundle.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     sh /path/to/git_reset_history.sh
#
#     Run it from the working tree of the repository to rewrite. It takes no
#     arguments: the remote is always origin and the branch is always master.
#
# Requirements:
# - A POSIX.1-2008 sh
# - Git 2.23 or later (the script uses git switch)
# - A remote named origin and a branch named master
# - Permission to fetch from origin, force-push master, and delete remote tags
# - Write permission in the parent directory, for the backup bundle
# - The standard du utility
#
# Notes:
# - The script does not stop when a command fails; each command runs in
#   order, and the status and log commands show the state along the way.

# Check the current state
git status
git branch
git stash list
git tag

# Match the remote state
git fetch --prune --tags origin
git switch master
git pull --ff-only origin master

# Save the current origin/master SHA
OLD_MASTER=$(git rev-parse origin/master)
echo "$OLD_MASTER"

# Keep the current history in a bundle
git bundle create ../repository-before-rewrite.bundle --all
git bundle verify ../repository-before-rewrite.bundle

# Create a new root commit on an orphan branch
git checkout --orphan new-master
git add -A
git status
git commit -m "Initial commit"

# Show the new history
git log --oneline --decorate

# Confirm that the files of the old master and the new HEAD are identical
git diff "$OLD_MASTER" HEAD

# Replace master with the new history
git branch -M master

# Update the remote master
git push \
  --force-with-lease=master:"$OLD_MASTER" \
  origin master

# Delete the remote tags
git tag | while IFS= read -r tag; do
    git push origin ":refs/tags/$tag"
done

# Delete the local tags
git tag | while IFS= read -r tag; do
    git tag -d "$tag"
done

# Measure the repository before the cleanup
du -sh .git
git count-objects -vH

# Drop the reflog and the unreachable objects
git reflog expire --expire=now --expire-unreachable=now --all
git gc --prune=now --aggressive

# Measure the repository after the cleanup
du -sh .git
git count-objects -vH

# Check the final state
git fetch --prune --no-tags origin
git log --all --oneline --decorate
git tag
git ls-remote --heads origin
git ls-remote --tags origin
