#!/bin/bash

SERVERIP=192.168.0.74 # Plex Server IP relative to where this script is running
STATUSPG=/var/www/public_html/index.html # Web page to update 
PLEXPORT=32400 # Plex server port relative to the system where this script runs- Typically 32400

ping -c 1 $SERVERIP > /dev/null 2>&1
if [ $? -ne 0 ]
then
sed -i '/Server Status/c\                    <p class="text-faded">Server Status:<font color="red">Down<\/font><\/p>' $STATUSPG
else
sed -i '/Server Status/c\                    <p class="text-faded">Server Status:<font color="green">Up<\/font><\/p>' $STATUSPG
fi

nc -z $SERVERIP $PLEXPORT
if [ $? -ne 0 ]
then
sed -i '/Plex Status/c\                    <p class="text-faded">Plex Status:<font color="red">Down<\/font><\/p>' $STATUSPG
else
sed -i '/Plex Status/c\                    <p class="text-faded">Plex Status:<font color="green">Up<\/font><\/p>' $STATUSPG
fi
