#!/usr/bin/env bash

set -e

mount /dev/sdb1 /mnt
rsync -ru . /mnt/
sync
umount /mnt

echo "SDCard Updated"
