#!/usr/bin/env bash

VERSION_NUMBER=$(git rev-list --count master)
echo $VERSION_NUMBER
./gradlew assembleRelease
