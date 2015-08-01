#!/bin/bash -x

# Script for backing up ownCloud -- Data is stored in /media/backupDisk/owncloud_backup

# Must be run by root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi


current_date=`date +"%Y%m%d"`

echo "ownCloud backup will be done in /media/backupDisk/owncloud_backup_"$current_date"/"

echo "Copy config folder..."
rsync -r /var/www/owncloud/config  /media/backupDisk/owncloud_backup_"$current_date"/

echo "Copy mySQL database..."
mysqldump -ubori -pboribrambori7399 owncld > /media/backupDisk/owncloud_backup_"$current_date"/sql_backup.bak


echo "Copy data folder..."
rsync -r --stats  /media/dataDisk/owncloud/data   /media/backupDisk/owncloud_backup_"$current_date"/ > backup_stats.txt
