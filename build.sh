#!/bin/bash
AV_USERNAME=${AV_USERNAME:-}
AV_PASSWORD=${AV_PASSWORD:-}

if [ -z "${AV_USERNAME}" ] || [ -z "${AV_PASSWORD}" ]; then
    echo -e "Valid license username and password are required to download Eset Server Security."
    echo -e "Enter your license credentials:"
    read -p 'Username: ' AV_USERNAME
    read -sp 'Password: ' AV_PASSWORD
    echo -e ""
fi
docker build --no-cache=true --pull --build-arg AV_USERNAME=${AV_USERNAME} --build-arg AV_PASSWORD=${AV_PASSWORD} -t esets -f ./Dockerfile .
