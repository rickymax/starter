#!/bin/bash
echo "=================================================="
echo " Generate CF Login Command"
echo "=================================================="

if [[ -n "$1" ]]; then
    CF_DOMAIN=$1
else
    read -r -p "Enter CF domain name: " CF_DOMAIN
fi

cat << EOF >> cl
#!/bin/bash
cf login -a api.$CF_DOMAIN -u admin -p `bosh int /opt/spacex/workspaces/cf-vars.yml --path /cf_admin_password` --skip-ssl-validation
EOF

chmod +x cl

mv cl /usr/local/bin

exit 0
