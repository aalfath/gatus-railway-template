#!/bin/sh
set -eu

# GATUS_CONFIG holds the whole config.yaml; without it the bundled example is used.
# Gatus expands ${VAR} references inside the file, so secrets can stay in their own variables.
if [ -n "${GATUS_CONFIG:-}" ]; then
  printf '%s\n' "$GATUS_CONFIG" > "$GATUS_CONFIG_PATH"
else
  cp /etc/gatus/default.yaml "$GATUS_CONFIG_PATH"
fi
chown gatus:gatus "$GATUS_CONFIG_PATH"

# Volumes mount root-owned; fix the top level only.
mkdir -p /data
[ "$(stat -c %u /data)" = "10001" ] || chown gatus:gatus /data

exec su-exec gatus /usr/local/bin/gatus
