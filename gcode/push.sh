#!/usr/bin/env bash

set -e

mount /dev/sdb1 /mnt
cp *.gcode /mnt
sync
umount /mnt

