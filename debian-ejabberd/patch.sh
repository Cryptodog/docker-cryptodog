#!/usr/bin/env bash
# Patch the ejabberd Debian package to disable room moderators.

set -eu -o pipefail

echo 'deb-src http://deb.debian.org/debian bookworm main' >> /etc/apt/sources.list
apt-get update
apt-get -y install packaging-dev
echo installed packaging-dev
apt-get -y build-dep ejabberd
echo installed ejabberd build-dep
apt-get -y source ejabberd

cd ejabberd-*
dch --nmu "Remove owner affiliation from MUC room creators."
quilt push -a || true
quilt new ejabberd.no-muc-owner.patch
quilt add src/mod_muc_room.erl

# https://sources.debian.org/src/ejabberd/23.01-1/src/mod_muc_room.erl/#L297
sed -i "s/State = set_affiliation(Creator, owner,/State = set_affiliation(Creator, none,/" src/mod_muc_room.erl

quilt refresh
debuild -us -uc

# Install the generated package and its dependencies
# XXX: dpkg could fail for reasons other than unmet dependencies.
# In that case, it might look like the build succeeded when apt-get -f install completes without error
dpkg -i ../ejabberd_*.deb || apt-get -f -y install
dpkg -i ../ejabberd_*.deb
