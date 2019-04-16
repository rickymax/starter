#!/bin/bash
echo "=================================================="
echo " Generate BOSH Login Command"
echo "=================================================="

if [[ -n "$1" && -n "$2" ]]; then
    BOSH_ENDPOINT=$1
    BOSH_ENV=$2
else
    read -r -p "Enter BOSH aliased environment name (default 10.0.0.100): " BOSH_ENDPOINT
    read -r -p "Enter BOSH aliased environment name (default spacex): " BOSH_ENV

    if [[ -z "$BOSH_ENDPOINT" ]]; then
        BOSH_ENDPOINT=10.0.0.100
    fi

    if [[ -z "$BOSH_ENV" ]]; then
        BOSH_ENV=spacex
    fi
fi

cat << EOF >> bl
#!/bin/bash
bosh -e $BOSH_ENDPOINT alias-env $BOSH_ENV --ca-cert <(bosh int /opt/spacex/creds.yml --path /director_ssl/ca)
bosh -e $BOSH_ENV login < /usr/local/bin/director_credentails
EOF

cat << EOF >> director_credentails
admin
`bosh int /opt/spacex/creds.yml --path /admin_password`
EOF

chmod +x bl

mv bl /usr/local/bin
mv director_credentails /usr/local/bin

exit 0
