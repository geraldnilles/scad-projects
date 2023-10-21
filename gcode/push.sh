#!/usr/bin/env bash

set -e

mount /dev/mmcblk0p1 /mnt
rsync -ru . /mnt/
sync
umount /mnt

echo "SDCard Updated"
