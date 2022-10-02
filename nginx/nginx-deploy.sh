date

pwd

ls -l


echo '#Setting env variables...'
cat nginx-vars.sh

chmod +x nginx-vars.sh
source ./nginx-vars.sh

chmod +x nginx-conf.sh
./nginx-conf.sh

echo '#removing for web_infra_certbot service'
sleep 5
docker service rm web_infra_certbot
docker service inspect web_infra_certbot

echo '#removing for web_infra_nginx service'
docker service rm web_infra_nginx
docker service inspect web_infra_nginx

echo '#Sleep for 10 seconds...'
sleep 10

echo '#deploying web_infra stack...'
docker stack deploy -c nginx-certbot-stack.yml --prune web_infra

echo '#Sleep for 5 seconds...'
sleep 5

echo '#List of services...'
docker service ls

echo '#List of containers...'
docker ps

echo '#Show nginx service logs...'
docker service logs web_infra_nginx

nginx_id=`docker ps -qf "name=^web_infra_nginx*"`
echo nginx_id=$nginx_id

echo '#Reloading nginx...'
docker exec $nginx_id nginx -s reload

echo '#Sleep for 5 seconds...'
sleep 5

certbot_id=`docker ps -qf "name=^web_infra_certbot*"`
echo certbot_id=$certbot_id

chmod +x init-letsencrypt.sh
./init-letsencrypt.sh

docker exec $certbot_id ls -l
docker exec $certbot_id ls -la /etc/letsencrypt/
docker exec $certbot_id rm /etc/letsencrypt/.certbot.lock
docker exec $certbot_id ls -la /etc/letsencrypt/
docker exec $certbot_id ps -a

echo '#Requesting certificates...'

chmod +x request-certificate.sh

./request-certificate.sh ${PORTAINER_SUB_DOMAIN}
./request-certificate.sh ${EXPRESS_SUB_DOMAIN}
./request-certificate.sh ${CPO_SERVER_SUB_DOMAIN}
./request-certificate.sh ${CPO_DASHBOARD_SUB_DOMAIN}
./request-certificate.sh ${CPO_ODATA_SUB_DOMAIN}
./request-certificate.sh ${CPO_OCPI_SUB_DOMAIN}
./request-certificate.sh ${CPO_OCPP_JSON_SUB_DOMAIN}
./request-certificate.sh ${CPO_OCPP_SOAP_SUB_DOMAIN}
./request-certificate.sh ${CPO_ADMIN_SUB_DOMAIN}

echo '#adding crontab ' $line
docker exec $certbot_id crontab -u $(whoami) -l
docker exec $certbot_id echo "30 23 * * * certbot renew --dry-run" | crontab -u $(whoami) -
docker exec $certbot_id crontab -u $(whoami) -l




chmod +x nginx-reload.sh
./nginx-reload.sh
