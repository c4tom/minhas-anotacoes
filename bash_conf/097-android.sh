export ANDROID_SDK_ROOT=/desenv/Android/Sdk

[[ -f $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager ]] || { 
    # Para rodar o AVD precisa do ANDROID SDK

    # This function install cmdlinetools (with AVD Manager)
    ct_android_AVD_install() {

        if [ ! -f $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/avdmanager ]
        then
            cd /tmp/
            #https://mirrors.cloud.tencent.com/AndroidSDK/commandlinetools-linux-9645777_latest.zip
            local FILENAME_CMD="commandlinetools-linux-9477386_latest.zip"
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
    return ; 
}

[[ -f /usr/local/bin/apktool ]] || {

    # https://ibotpeaches.github.io/Apktool/install/
    ct_apktool_install() {
        local APKTOOL_JAR_VERSION=2.7.0
        cd /tmp
        echo_and_run curl -L -k -o apktool https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
        echo_and_run curl -L -k -o apktool.jar https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_$APKTOOL_JAR_VERSION.jar
        https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.7.0.jar
        echo_and_run chmod +x apktool.jar apktool
        echo_and_run sudo cp -f apktool.jar apktool /usr/local/bin

    }
    return ;
}

export ANDROID_PLATFORM_TOOLS=$ANDROID_SDK_ROOT/platform-tools
export ANDROID_CMDL_TOOLS=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
export ANDROID_ADB=$ANDROID_PLATFORM_TOOLS/adb
export ANDROID_EMULATOR=$ANDROID_SDK_ROOT/emulator/emulator
export ANDROID_AVDMANAGER=$ANDROID_CMDL_TOOLS/avdmanager
export ANDROID_SDKMANAGER=$ANDROID_CMDL_TOOLS/sdkmanager

ct_androidInstallEmulator() {
    $ANDROID_SDKMANAGER --sdk_root=$ANDROID_SDK_ROOT --install emulator
}


# Google Play Intel x86 Atom System Image (system-images;android-24;google_apis_playstore;x86)

ct_android_SDK_Install() {
    $ANDROID_SDKMANAGER --sdk_root=$ANDROID_SDK_ROOT --list | grep system-images
    echo "Escolha qual deseja instalar: "
    read opcao
    echo_and_run $ANDROID_SDKMANAGER --sdk_root=$ANDROID_SDK_ROOT --install "$opcao"
}

# https://gist.github.com/mrk-han/66ac1a724456cadf1c93f4218c6060ae

ct_android_AVD_CreateEmulatorpixel_4_0_play() {
    echo_and_run $ANDROID_SDKMANAGER --sdk_root=$ANDROID_SDK_ROOT --install "system-images;android-24;google_apis_playstore;x86"
    local cmd=$( echo "no" | $ANDROID_AVDMANAGER --verbose create avd --force --name "Pixel_4_API_24_NOUGAT_xxx" --device "pixel" --package "system-images;android-24;google_apis_playstore;x86" --tag "google_apis_playstore" --abi "x86")
    echo_and_run $cmd
}

ct_android_AVD_CreateEmulatorPixelAOSP() {
    # Install AVD files
    yes | $ANDROID_SDKMANAGER --install 'system-images;android-29;default;x86'
    yes | $ANDROID_SDKMANAGER --licenses

    # Create emulator
    echo "no" | $ANDROID_AVDMANAGER create avd -n Pixel_API_29_AOSP -d pixel --package 'system-images;android-29;default;x86' --force

    $ANDROID_EMULATOR -list-avds

    # Set screen dimensions
    echo "hw.lcd.density=420" >> ~/.android/avd/Pixel_API_29_AOSP.avd/config.ini
    echo "hw.lcd.height=1920" >> ~/.android/avd/Pixel_API_29_AOSP.avd/config.ini
    echo "hw.lcd.width=1080" >> ~/.android/avd/Pixel_API_29_AOSP.avd/config.ini

    echo "Starting emulator and waiting for boot to complete..."
    nohup $ANDROID_EMULATOR -avd Pixel_API_29_AOSP -no-snapshot -no-window -no-audio -no-boot-anim -camera-back none -camera-front none -qemu -m 2048 > /dev/null 2>&1 &
    $ANDROID_ADB wait-for-device shell 'while [[ -z $(getprop sys.boot_completed | tr -d '\r') ]]; do sleep 1; done; input keyevent 82'

    echo "Emulator has finished booting"
    $ANDROID_ADB devices
}

[[ -f $ANDROID_EMULATOR ]] || { return ; }

ct_android_AVD_RunEmulator() {
    echo "Escolha qual AVD?"
    echo 
    echo_and_run $ANDROID_EMULATOR -list-avds
    
    read AVD
    echo ""
    echo_and_run $ANDROID_EMULATOR -verbose -avd $AVD
}


ct_android_dev_dashboard() {

    echo "######### SDK Installed #######"
    $ANDROID_SDKMANAGER --list_installed

    echo "######### AVDs #######"
    $ANDROID_EMULATOR -list-avds
}