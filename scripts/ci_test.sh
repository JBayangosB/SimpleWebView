#!/usr/bin/env bash

echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n SMOOGLE -k "system-images;android-25;google_apis;armeabi-v7a" -f
export DISPLAY=:0.0
if [[ $($ANDROID_HOME/platform-tools/adb devices -l | wc -l) -eq 2 ]]; then
	echo "😕  No Emulator or Device Running"
	if [[ $($ANDROID_HOME/tools/emulator -list-avds | wc -l) -gt 0 ]]; then
		emulators=($($ANDROID_HOME/tools/emulator -list-avds))
		firstEmulator=${emulators[0]}
		echo "🚀  Starting Emulator -- '@$firstEmulator'"
		$ANDROID_HOME/tools/emulator @$firstEmulator -use-system-libs -qemu -no-skin -no-audio -no-window -verbose
		EMULATOR_PID=$!
		while [ $($ANDROID_HOME/platform-tools/adb devices -l | wc -l) -lt 3 ]
		do
			echo -n "💤"
			sleep 1
		done

		echo "👏  Emulator started... waiting for booting to complete"
		WAIT_CMD="platform-tools/adb shell getprop init.svc.bootanim"
		echo "Waiting for emulator to boot 👢  (may get a some 'error:device offline' while the emulator first starts)"

		until $WAIT_CMD | grep -m 1 stopped; do

		  if ! ps -p $EMULATOR_PID > /dev/null
   		     then
   		        echo "😬 Looks like the emulator process is gone!  Failing the build"
				exit 1
		  fi

		  echo "📱👢 ???"
		  sleep 1
		done

		echo "👏  Emulator finished booting"
	else
		echo "😱  No emulators available"
		exit 1
	fi
else
	echo "👏  Found Android Device or Emulator - Good to start tests"
fi
echo "OH MY"
./gradlew connectedAndroidTest