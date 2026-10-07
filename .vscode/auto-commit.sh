#!/bin/bash

# Auto-commit script with timestamp and changed files
# Usage: auto-commit.sh [--no-push]

NO_PUSH=false
if [ "$1" = "--no-push" ]; then
    NO_PUSH=true
fi

cd /workdir || exit 1

# Check if there are any changes
if ! git diff --quiet || ! git diff --cached --quiet; then
    # Get list of changed files
    CHANGED_FILES=$(git diff --name-only --diff-filter=ACM)
    STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM)
    
    # Combine both lists, filter empty lines
    FILES_TO_COMMIT=$(echo -e "$CHANGED_FILES\n$STAGED_FILES" | grep -v '^$' | sort -u | tr '\n' ', ' | sed 's/,$//')
    
    # If no files to commit, exit
    if [ -z "$FILES_TO_COMMIT" ]; then
        exit 0
    fi
    
    # Create commit message with timestamp and file names
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    COMMIT_MESSAGE="Auto-commit [$TIMESTAMP] - Changed: $FILES_TO_COMMIT"
    
    # Stage all changes
    git add -A
    
    # Commit
    git commit -m "$COMMIT_MESSAGE"
    
    # Push if remote exists and --no-push flag is not set
    if [ "$NO_PUSH" = false ] && git config --get remote.origin.url > /dev/null 2>&1; then
        git push
    fi
fi

exit 0
