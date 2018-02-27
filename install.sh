docker build -t rodder_server --compress -f ./Dockerfile .
docker stack deploy --prune -c docker-stack.yml rudder
