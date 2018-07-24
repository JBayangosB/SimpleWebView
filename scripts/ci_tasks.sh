/usr/bin/env sh

set -x
./gradlew assembleRelease
./gradlew assembleReleaseUnitTest
echo $?
