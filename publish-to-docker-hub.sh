#!/bin/bash

IMAGE_NAME="mottor1/zabbix-agent"
VERSION=$(cat VERSION.md | head -n 1)

docker login ## Enter login and pass

docker build --tag "$IMAGE_NAME:latest" --tag "$IMAGE_NAME:$VERSION" .

for i in "$VERSION" "latest"; do
  printf "\n------\npushing '$IMAGE_NAME:$i'\n";
  docker push "$IMAGE_NAME:$i";
done

echo " "
echo "[ DONE ]"
echo " "
