#!/bin/bash

set -e

cat <<'EOF' | lolcat

┌─┐┬┌┬┐┬ ┬┬ ┬┌┐
│ ┬│ │ ├─┤│ │├┴┐
└─┘┴ ┴ ┴ ┴└─┘└─┘

EOF

if [ -z "$1" ] || [ -z "$2" ]; then
    echo -e "Usage: \e[0;31m ❌ hub-push.sh <commit-message> <branch-name>\e[0m"
    exit 1
fi

eval "$(ssh-agent -s)" > /dev/null
OUTPUT=$(ssh-add ~/.ssh/github 2>&1)

if [[ $OUTPUT =~ Identity\ added:\ .*\((.*)\) ]]; then
    EMAIL=${BASH_REMATCH[1]}
    echo -e "\e[1;32m ✔ Identity added for:\e[0m \e[1;33m$EMAIL\e[0m"
else
    echo -e "\e[1;31m✖ Failed to add identity\e[0m"
    echo -e "\e[0;90m$OUTPUT\e[0m"
fi

# git s5
echo -e "\n\e[1;36m 📦 Git status:\e[0m"
git ss
git add .
git commit -m "$1"
PUSH_OUTPUT=$(git push origin "$2" 2>&1)

echo -e "\n\e[1;36m$PUSH_OUTPUT\e[0m"


echo -e "\e[1;32m ✔ Changes pushed successfully to \e[1;34morigin/$2\e[0m."

repo=$(basename "$(git rev-parse --show-toplevel)")

notify-send -u normal -a "GitHub" \
"<b><span foreground='#44cc44'>✅ $repo: Push Successful</span></b>" \
"<i>Branch:</i> <span foreground='#61afef'>$2</span>\n<i>Remote:</i> <span foreground='#e5c07b'>origin/$2</span>"

