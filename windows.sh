#!/bin/bash

# $USERPROFILE/Downloads/internal

export JAVA_HOME="$(cygpath -u D:/Softwares/jdk-11.0.13+8)" && \
export ANDROID_HOME="$(cygpath -u $USERPROFILE/Downloads/commandlinetools-win-9477386_latest)" && \
export PATH="$ANDROID_HOME/cmdline-tools/bin:/usr/local/bin/:/usr/bin/:$JAVA_HOME:$JAVA_HOME/bin" && \
echo $ANDROID_HOME && \
echo $JAVA_HOME && \
sdkmanager.bat --list --sdk_root=$ANDROID_HOME && \
yes | sdkmanager.bat --sdk_root=$ANDROID_HOME --install "platform-tools" "platforms;android-23" "build-tools;27.0.1" && \
\
export JAVA_HOME="$(cygpath -u D:/Softwares/jdk-11.0.13+8)" && \
export ANDROID_HOME="$(cygpath -u $USERPROFILE/Downloads/commandlinetools-win-9477386_latest)" && \
export PATH="$ANDROID_HOME/cmdline-tools/bin:/usr/local/bin/:/usr/bin/:$JAVA_HOME:$JAVA_HOME/bin" && \
echo $ANDROID_HOME && \
echo $JAVA_HOME && \
cd HelloWorld && \
\
rm -v -f -r ./obj && \
rm -v -f -r ./bin && \
rm -v -f -r ./key && \
mkdir ./obj && \
mkdir ./bin && \
mkdir ./key && \
\
export JAVA_HOME="$(cygpath -u D:/Softwares/jdk8u322-b06)" && \
$ANDROID_HOME/build-tools/27.0.1/aapt package -v -f -m -S ".\src\res" -J ".\src\src" -M ./src/AndroidManifest.xml -I $ANDROID_HOME/platforms/android-23/android.jar && \
javac -d ./obj/ -source 1.7 -target 1.7 -classpath $ANDROID_HOME/platforms/android-23/android.jar -sourcepath ./src/src/ ./src/src/org/kolodez/HelloWorld/* && \
$ANDROID_HOME/build-tools/27.0.1/dx.bat --dex --output=".\bin\classes.dex" ".\obj" && \
$ANDROID_HOME/build-tools/27.0.1/aapt package -f -M ./src/AndroidManifest.xml -S ".\src\res" -I $ANDROID_HOME/platforms/android-23/android.jar -F "./bin/HelloWorld.unsigned.apk" ./bin
keytool -genkeypair -validity 10000 -dname "CN=Kolodez, OU=Kolodez, O=Kolodez, C=US" -keystore ./key/mykey.keystore -storepass mypass -keypass mypass -alias myalias -keyalg RSA
jarsigner -keystore ./key/mykey.keystore -storepass mypass -keypass mypass -signedjar ./bin/HelloWorld.signed.apk ./bin/HelloWorld.unsigned.apk myalias
$ANDROID_HOME/build-tools/27.0.1/zipalign -f 4 ./bin/HelloWorld.signed.apk ./bin/HelloWorld.apk