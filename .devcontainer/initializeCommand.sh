#!/usr/bin/env zsh
# Runs on the host. Exports the host gh token so the container can log in with it.
set -u
cd "$(dirname "$0")"

# VS Code launched from the GUI may not have Homebrew on PATH
export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"

TOKEN_FILE=".gh-token"
rm -f "$TOKEN_FILE"

if command -v gh >/dev/null 2>&1; then
	token="$(gh auth token --hostname github.com 2>/dev/null || true)"
	if [ -n "$token" ]; then
		(umask 077 && printf '%s\n' "$token" >"$TOKEN_FILE")
		echo "gh token exported for devcontainer"
	else
		echo "gh is not logged in on host, skipping"
	fi
else
	echo "gh not found on host, skipping"
fi

exit 0
