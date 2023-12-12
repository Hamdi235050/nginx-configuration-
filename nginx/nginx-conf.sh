ls -l
mkdir -p data/nginx
mkdir -p data/certbot/www
echo '<h1>hello</h1>' > data/certbot/www/index.html

echo '#Removin existing config file...'

rm -f data/nginx/app.conf
cd data/nginx

cd ..
cd ..

cat app.conf
envsubst < app.conf > new-app.conf
cat new-app.conf

echo '#Moving http config file...'
mv new-app.conf data/nginx/app.conf

ls -l data/nginx/ ;
