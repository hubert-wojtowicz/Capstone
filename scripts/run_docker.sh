#!/usr/bin/env bash

appName="jokes-app"
appContainerHostPort=8000

docker build --tag=$appName ..

docker images

echo "Expose app container on host port: $appContainerHostPort"
docker run -p $appContainerHostPort:80 $appName