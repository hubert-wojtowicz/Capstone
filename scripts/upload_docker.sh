#!/usr/bin/env bash

login="hubertos"
appName="jokes-app"
dockerpath="$login/$appName"

echo "Sign in to $login DockerHub account"
docker login -u "$login"
echo "Docker ID and Image: $dockerpath"

docker tag $appName $dockerpath
docker push $dockerpath