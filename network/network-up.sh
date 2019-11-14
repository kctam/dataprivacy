echo "###"
echo "### bring up all containers"
echo "###"

docker-compose -f docker-compose.yaml up -d
docker ps

echo "###"
echo "### make sure there are 8 containers up and running"
echo "###"