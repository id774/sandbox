#!/bin/sh
# Reset the commit history of a Git repository to a single Initial commit,
# keeping the working tree and the remote repository itself.
# Run this only against a repository whose history may be discarded.

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
