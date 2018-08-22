#!/bin/bash
WORKSPACES=/opt/spacex/workspaces

readarray array <<< $( cat "$@" )

if [ -d $WORKSPACES ]; then
    cd $WORKSPACES/tmp
fi

for element in ${array[@]}
do
  echo "clonning $element"
  git clone $element
done
