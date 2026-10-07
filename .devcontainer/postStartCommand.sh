#!/usr/bin/env bash
set -u

# Share GitHub credentials with the host.
# initializeCommand.sh writes the host's gh token to .devcontainer/.gh-token.
# Log in with it, then delete the file so the token does not stay in the workspace.
# Git config goes to --system so the host's ~/.gitconfig (bind-mounted) is not modified.
TOKEN_FILE="/workdir/.devcontainer/.gh-token"
if [ -s "$TOKEN_FILE" ] && command -v gh >/dev/null 2>&1; then
	echo "Logging in to GitHub with host token..."
	if gh auth login --hostname github.com --git-protocol https --insecure-storage --with-token <"$TOKEN_FILE"; then
		git config --system --replace-all credential.https://github.com.helper '!/usr/bin/gh auth git-credential'
		# Use HTTPS + token even for SSH remotes (also works from cron, which has no ssh-agent)
		git config --system --replace-all url.https://github.com/.insteadOf git@github.com:
		git config --system --add url.https://github.com/.insteadOf ssh://git@github.com/
		gh auth status
	else
		echo "gh auth login failed, continuing without GitHub credentials"
	fi
fi
rm -f "$TOKEN_FILE"

# Start cron only when the service and init script exist. Do not fail container startup
# if cron is not available or starting it fails.
if command -v service >/dev/null 2>&1 && [ -f /etc/init.d/cron ]; then
	echo "Starting cron..."
	if ! service cron start; then
		echo "service cron start failed, continuing without cron"
	fi

	if [ -f /root/.cron-state ] && grep -q 'stopped' /root/.cron-state; then
		echo "Detected stopped state; stopping cron..."
		service cron stop || true
	fi
else
	echo "cron not available, skipping start"
fi

exit 0
