#!/bin/bash
BOSH_CREDS=/opt/spacex/creds.yml
BOSH_STATE=/opt/spacex/state.json
CF_VARS=/opt/spacex/workspaces/cf-vars.yml
OPENSTACK_RC=/opt/spacex/scripts/openrc.sh

if [ ! -f "$BOSH_CREDS" ]; then
    echo "$BOSH_CREDS not found."
    exit 1
elif [ ! -f "$BOSH_STATE" ]; then
    echo "$BOSH_STATE not found."
    exit 1
elif [ ! -f "$CF_VARS" ]; then
    echo "$CF_VARS not found."
    exit 1
elif [ ! -f "$OPENSTACK_RC" ]; then
    echo "$OPENSTACK_RC not found."
    exit 1
fi

exit 0
