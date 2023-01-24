#!/bin/bash

APPS=$(kubectl get -A cronjobs.batch | grep snap | awk '{ print $2 }')
cd ..

for LINE in $APPS; do

    APP=${LINE%?????}

    task ko:restore APP=$APP

done
