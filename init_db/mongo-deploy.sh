
docker service rm ev_mongodb
docker service rm ev_mongo-express
docker service rm ev_enablereplset
docker volume  rm ev_mongodb



pwd

chmod +x mongo-vars.sh
source ./mongo-vars.sh

#liste des variables
cat mongo-vars.sh


docker stack deploy -c mongo-stack.yml ev

docker service ls

