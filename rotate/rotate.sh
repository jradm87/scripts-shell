#!/bin/sh
#  script to rotate samba activity log on freenas.
samba_activity="/mnt/STORAGE/Logs/samba/activity/activity.log"
now=$(date +"_%H%M%S_%d_%m_%Y")
date=$(date +"%d_%m_%Y")
archivfolder="/mnt/STORAGE/Logs/samba/activity/activity/$date"
archivfile="activity_$now.log"

max_size=30
max_size=$((max_size*1024*1024))
size=`ls -l $samba_activity | awk '{print $7}'`

if [ $size -gt $max_size ]; then
    ### create archiv folder if not exist
    if [ ! -d "$archivfolder" ]; then
        mkdir $archivfolder
    fi

    ### backup and create samba activity log ###
    cp $samba_activity "$archivfolder/$archivfile"
    ### stop log service ###
    service syslog-ng stop
    rm $samba_activity
    echo "new log from $now" > $samba_activity

    ### again start log service ###
    service syslog-ng start
fi


