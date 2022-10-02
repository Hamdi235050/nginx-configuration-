chmod +x portainer-vars.sh
source ./portainer-vars.sh

echo '#Stack deploy...'
docker stack deploy -c portainer-agent-stack.yml --prune infra

echo '#List of containers...'
docker ps

echo '#List of services...'
docker service ls
