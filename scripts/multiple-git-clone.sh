#!/bin/bash
WORKSPACES=/opt/spacex/workspaces

readarray array <<< $( cat "$@" )

if [ -d $WORKSPACES ]; then
    cd $WORKSPACES
    for element in ${array[@]}
    do
      echo "clonning $element"
      git clone $element
    done
    exit 0
else
    echo "$WORKSPACES not found"
    exit 1
fi
