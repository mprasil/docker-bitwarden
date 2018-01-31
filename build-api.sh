#!/usr/bin/env sh

REPO=https://github.com/universal/bitwarden-ruby.git
BRANCH=additions

echo "---- Installing tools ----"
apk add -U \
    git \
    openssl \
    sqlite-dev \
    build-base \
    linux-headers

echo "---- Clonning repo ----"
git clone $REPO bitwarden
cd bitwarden || ( echo "Failed to clone" ; exit 2 )
git checkout $BRANCH

echo "--- Installing ----"
bundle install  --deployment --without dev development test

echo "---- Done ----"
