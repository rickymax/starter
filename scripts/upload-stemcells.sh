#!/bin/bash
BOSH_STEMCELLS=/opt/spacex/stemcells/*

echo "=================================================="
echo " Upload BOSH Stemcells"
echo "=================================================="
read -r -p "Enter BOSH aliased environment name (default spacex): " BOSH_ENV

upload_local_stemcells(){
    for f in $BOSH_STEMCELLS
    do
        if [[ ${f: -4} == ".tgz" ]]; then
            bosh -e $BOSH_ENV upload-stemcell $f
        fi
    done
}

list_stemcells(){
    bosh -e $BOSH_ENV stemcells
}

if [[ -z "$BOSH_ENV" ]]; then
    BOSH_ENV=spacex
fi

bosh -e $BOSH_ENV env
if [ "$?" -ne 0 ];then
  echo "Error: failed to execute 'bosh -e $BOSH_ENV env'"
  exit 1
fi

upload_local_stemcells
list_stemcells

# Success
exit 0
