#!/usr/bin/env bash
set -u

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
