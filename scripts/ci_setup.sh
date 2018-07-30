#!/usr/bin/env bash

apt-get --quiet update --yes
apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1
export ANDROID_SDK_HOME=$PWD/__ci
export ANDROID_HOME=$ANDROID_SDK_HOME/android-sdk-linux
export GRADLE_USER_HOME=$ANDROID_SDK_HOME
mkdir -p $ANDROID_HOME
wget --quiet --output-document=$ANDROID_SDK_HOME/android-sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
unzip --q $ANDROID_SDK_HOME/android-sdk-tools.zip -d $ANDROID_HOME
echo y | $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-26" >/dev/null
echo y | $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" >/dev/null
echo y | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;27.0.3" >/dev/null
echo y | $ANDROID_HOME/tools/bin/sdkmanager "extras;android;m2repository" >/dev/null
echo y | $ANDROID_HOME/tools/bin/sdkmanager "extras;google;google_play_services" >/dev/null
echo y | $ANDROID_HOME/tools/bin/sdkmanager "emulator" >/dev/null
echo y | $ANDROID_HOME/tools/bin/sdkmanager "system-images;android-25;google_apis;armeabi-v7a" >/dev/null
export PATH=$PATH:$ANDROID_HOME/platform-tools/
export LD_LIBRARY_PATH=${ANDROID_HOME}/tools/lib64
chmod +x ./gradlew