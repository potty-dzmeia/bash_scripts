#!/bin/bash -x

# Script for backing up ownCloud -- Data is stored in /media/backupDisk/owncloud_backup

# Must be run by root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# 1. Make sure you have enough space on the backup disk

# 2. Make sure the backup disk is mounted in the proper directory
# sudo mount  /dev/sdb1 /media/backupDisk/

service apache2  stop

current_date=`date +"%Y%m%d"`

echo "Creating directory: /media/backupDisk/owncloud_backup_"$current_date"/"
mkdir /media/backupDisk/owncloud_backup_"$current_date"/

echo "ownCloud backup will be done in /media/backupDisk/owncloud_backup_"$current_date"/"

echo "Copy config folder..."
rsync -r /var/www/owncloud/config  /media/backupDisk/owncloud_backup_"$current_date"/

echo "Copy mySQL database..."
mysqldump -uowncloud -powncloud7388 owncloud > /media/backupDisk/owncloud_backup_"$current_date"/sql_backup.bak


echo "Copy data folder..."
rsync -r --stats  /media/data/owncloud   /media/backupDisk/owncloud_backup_"$current_date"/ > backup_stats.txt
