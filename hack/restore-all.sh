#!/bin/bash

APPS=$(kubectl get -A cronjobs.batch | grep snap | awk '{ print $2 }')
cd ..

for LINE in $APPS; do

    if [ $LINE != "plex-app-snap" ]; then
        APP=${LINE%?????????}
        task ko:restore APP=$APP

    fi

done
