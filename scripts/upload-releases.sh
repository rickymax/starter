#!/bin/bash
BOSH_RELEASES=/opt/spacex/releases/*

echo "=================================================="
echo " Upload BOSH Releases"
echo "=================================================="
read -r -p "Enter BOSH aliased environment name (default spacex): " BOSH_ENV

upload_local_releases(){
    for f in $BOSH_RELEASES
    do
        if [[ ${f: -4} == ".tgz" ]]; then
            bosh -e $BOSH_ENV upload-release $f
        fi
    done
}

list_releases(){
    bosh -e $BOSH_ENV releases
}

if [[ -z "$BOSH_ENV" ]]; then
    BOSH_ENV=spacex
fi

bosh -e $BOSH_ENV env
if [ "$?" -ne 0 ];then
  echo "Error: failed to execute 'bosh -e $BOSH_ENV env'"
  exit 1
fi

upload_local_releases
list_releases

# Success
exit 0
