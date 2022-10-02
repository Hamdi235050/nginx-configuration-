echo "# Requesting certificate for $1"
wget http://$1
cat index.html
rm index.html
certbot_id=`docker ps -qf "name=^web_infra_certbot*"`
echo certbot_id=$certbot_id
echo certbot certonly --debug --cert-name $1 --webroot --webroot-path /var/www/certbot --email ${EMAIL} -d $1 --rsa-key-size ${KEY_SIZE} --agree-tos --disable-hook-validation --force-renewal

docker exec $certbot_id certbot certonly --debug --cert-name $1 --webroot --webroot-path /var/www/certbot --email ${EMAIL} -d $1 --rsa-key-size ${KEY_SIZE} --agree-tos --disable-hook-validation 
