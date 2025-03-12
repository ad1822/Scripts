#!/bin/bash

set -e

eval "$(ssh-agent -s)" > /dev/null

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <commit-message> <branch-name>"
    exit 1
fi

git status
git add .
git commit -m "$1"
git push origin "$2"

echo "Changes pushed successfully to origin/$2."
