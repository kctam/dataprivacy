echo "###"
echo "### bring down all containers and clean up"
echo "###"

docker-compose -f docker-compose.yaml down -v
docker rm $(docker ps -aq)
docker rmi $(docker images dev-* -q)

echo "###"
echo "### all cleaned up"
echo "###"