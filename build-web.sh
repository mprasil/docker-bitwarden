#!/usr/bin/env sh

VERSION="1.26.0"
URL="https://github.com/bitwarden/web/archive/v${VERSION}.tar.gz"

echo "---- Installing Gulp ----"
npm install -g gulp-cli gulp

echo "---- Installing build related utils ----"
apk add --update-cache \
    curl \
    git

echo "---- Fetching sources ----"
mkdir vault-build && cd vault-build || ( echo "Failed to create vault-build" ; exit 1 )
curl -L "${URL}" | tar -xvz 
cd web*  || ( echo "Failed to unpack" ; exit 1 )

echo "---- Building ----"
git config --global url."https://github.com/".insteadOf ssh://git@github.com/
npm install
gulp dist:selfHosted

echo "---- Cleanup ----"
mv ./dist ../../vault
cd ../../ || ( echo "Failed to cleanup" ; exit 1 )
rm -rf vault-build


echo "---- Done ----"
