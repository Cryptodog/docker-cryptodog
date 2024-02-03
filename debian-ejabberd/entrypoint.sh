#!/usr/bin/env bash

set -eu -o pipefail

# Workaround for https://github.com/docker/for-linux/issues/138
# Otherwise, we'd just mount the tmpfs with the proper permissions in docker-compose.yml
chown ejabberd:ejabberd /run/ejabberd

# Drop privileges since this script has to run as root to modify tmpfs perms
exec su -c '/usr/sbin/ejabberdctl foreground' ejabberd
