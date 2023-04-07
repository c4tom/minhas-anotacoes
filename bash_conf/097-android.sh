export ANDROID_SDK_ROOT=/desenv/Android/Sdk


ct_androidInstallAVD() {

    if [ ! -f $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/avdmanager ]
    then
        cd /tmp/
        #https://mirrors.cloud.tencent.com/AndroidSDK/commandlinetools-linux-9645777_latest.zip
        local FILENAME_CMD="commandlinetools-linux-9645777_latest.zip"
        wget -c "https://dl.google.com/android/repository/$FILENAME_CMD"
        mkdir -p $ANDROID_SDK_ROOT; cd $ANDROID_SDK_ROOT
        unzip /tmp/$FILENAME_CMD
        cd cmdline-tools
        mkdir -p latest
        mv bin lib latest
    else
        echo "Já instalado"
    fi

    $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/avdmanager list avd
}


# https://ibotpeaches.github.io/Apktool/install/
ct_apktool_install() {
    local APKTOOL_JAR_VERSION=2.6.1
    cd /tmp
    echo_and_run curl -k -o apktool https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
    echo_and_run curl -k -o apktool.jar https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_$APKTOOL_JAR_VERSION.jar
    echo_and_run chmod +x apktool.jar apktool
    echo_and_run sudo cp -f apktool.jar apktool /usr/local/bin

}

[[ -f $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager ]] || { return ; }

export ANDROID_CMDL_TOOLS=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin


export PATH=$PATH:$ANDROID_CMDL_TOOLS

ct_androidInstallEmulator() {
    $ANDROID_CMDL_TOOLS/sdkmanager --sdk_root=$ANDROID_SDK_ROOT --install emulator
}


# Google Play Intel x86 Atom System Image (system-images;android-24;google_apis_playstore;x86)

ct_androidInstallSDK() {
    $ANDROID_CMDL_TOOLS/sdkmanager --sdk_root=$ANDROID_SDK_ROOT --list | grep system-images
    echo "Escolha qual deseja instalar: "
    read opcao
    echo_and_run $ANDROID_CMDL_TOOLS/sdkmanager --sdk_root=$ANDROID_SDK_ROOT --install "$opcao"
}

# https://gist.github.com/mrk-han/66ac1a724456cadf1c93f4218c6060ae

ct_androidCreateEmulatorpixel_4_0_play() {
    echo_and_run $ANDROID_CMDL_TOOLS/sdkmanager --sdk_root=$ANDROID_SDK_ROOT --install "system-images;android-24;google_apis_playstore;x86"
    local cmd=$( echo "no" | $ANDROID_CMDL_TOOLS/avdmanager --verbose create avd --force --name "Pixel_4_API_24_NOUGAT_xxx" --device "pixel" --package "system-images;android-24;google_apis_playstore;x86" --tag "google_apis_playstore" --abi "x86")
    echo_and_run $cmd
}

ct_androidCreateEmulatorPixelAOSP() {
    # Install AVD files
    yes | $ANDROID_HOME/tools/bin/sdkmanager --install 'system-images;android-29;default;x86'
    yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

    # Create emulator
    echo "no" | $ANDROID_HOME/tools/bin/avdmanager create avd -n Pixel_API_29_AOSP -d pixel --package 'system-images;android-29;default;x86' --force

    $ANDROID_HOME/emulator/emulator -list-avds

    # Set screen dimensions
    echo "hw.lcd.density=420" >> ~/.android/avd/Pixel_API_29_AOSP.avd/config.ini
    echo "hw.lcd.height=1920" >> ~/.android/avd/Pixel_API_29_AOSP.avd/config.ini
    echo "hw.lcd.width=1080" >> ~/.android/avd/Pixel_API_29_AOSP.avd/config.ini

    echo "Starting emulator and waiting for boot to complete..."
    nohup $ANDROID_HOME/emulator/emulator -avd Pixel_API_29_AOSP -no-snapshot -no-window -no-audio -no-boot-anim -camera-back none -camera-front none -qemu -m 2048 > /dev/null 2>&1 &
    $ANDROID_HOME/platform-tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed | tr -d '\r') ]]; do sleep 1; done; input keyevent 82'

    echo "Emulator has finished booting"
    $ANDROID_HOME/platform-tools/adb devices
}

[[ -f $ANDROID_SDK_ROOT/emulator/emulator ]] || { return ; }


# Define path emulator
ANDROID_EMULATOR="$ANDROID_SDK_ROOT/emulator/emulator"

ct_androidRunEmulatorAVD() {
    echo "Escolha qual AVD?"
    echo 
    echo_and_run $ANDROID_EMULATOR -list-avds
    
    read AVD
    echo ""
    echo_and_run $ANDROID_EMULATOR -verbose -avd $AVD
}

export ANDROID_HOME=$ANDROID_SDK_ROOT
export ANDROID_AVD_HOME=/Android/AVD


