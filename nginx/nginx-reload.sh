ls -l data/nginx/

export host='$host'
export request_uri='$request_uri'
export http_upgrade='$http_upgrade'
export remote_addr='$remote_addr'
export proxy_add_x_forwarded_for='$proxy_add_x_forwarded_for'
export scheme='$scheme'

echo '#Compiling https config file...'

PORTAINER_ID=`docker ps -qf "name=^infra_portainer*"`
echo PORTAINER_ID=$PORTAINER_ID

EXPRESS_ID=`docker ps -qf "name=^ev_mongo-express*"`
echo EXPRESS_ID=$EXPRESS_ID

CPO_SERVER_ID=`docker ps -qf "name=^wattzhub_cpo_ev_server*"`
echo CPO_SERVER_ID=$CPO_SERVER_ID

CPO_DASHBOARD_ID=`docker ps -qf "name=^wattzhub_cpo_ev_dashboard*"`
echo CPO_DASHBOARD_ID=$CPO_DASHBOARD_ID

nginx_id=`docker ps -qf "name=^web_infra_nginx*"`
echo nginx_id=$nginx_id

HOST=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1)
echo HOST=$HOST

PORTAINER_HOST=$HOST
EXPRESS_HOST=$HOST
CPO_SERVER_HOST=$HOST
CPO_DASHBOARD_HOST=$HOST
CPO_ODATA_HOST=$HOST
CPO_OCPI_HOST=$HOST
CPO_OCPP_JSON_HOST=$HOST
CPO_OCPP_SOAP_HOST=$HOST
CPO_ADMIN_HOST=$HOST

ODOO_HOST=$HOST

cat app-ssl.conf
envsubst < app-ssl.conf > new-app-ssl.conf
cat new-app-ssl.conf

echo '#Removing http config file...'
rm -f data/nginx/app.conf

echo '#Moving https config file...'
mv new-app-ssl.conf data/nginx/app.conf
ls -l data/nginx/ ;

# echo '#Updating hosts file...'
# docker exec $nginx_id echo -e "$HOST\thost" >> /etc/hosts ; cat /etc/hosts

echo '#Docker list...'
docker ps
echo nginx_id=$nginx_id


echo '#Reloading nginx...'
docker exec $nginx_id nginx -s reload
