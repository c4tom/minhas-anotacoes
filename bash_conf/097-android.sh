
ct_androidInstallAVD() {
    cd /tmp/
    wget -c "https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip"
    mkdir -p /Android/Sdk; cd /Android/Sdk
    unzip /tmp/commandlinetools-linux-7583922_latest.zip
}

[[ -f /Android/SDK/cmdline-tools/latest/bin/sdkmanager ]] || { return ; }

export ANDROID_CMDL_TOOLS=/Android/SDK/cmdline-tools/latest/bin
export ANDROID_SDK_ROOT=/Android/SDK

export PATH=$PATH:$ANDROID_CMDL_TOOLS

ct_androidInstallEmulator() {
    $ANDROID_CMDL_TOOLS/sdkmanager --sdk_root=$ANDROID_SDK_ROOT --install emulator
}


# Google Play Intel x86 Atom System Image (system-images;android-24;google_apis_playstore;x86)

ct_androidInstallSDK() {
    $ANDROID_CMDL_TOOLS/sdkmanager --sdk_root=$ANDROID_SDK_ROOT --list
    echo "Escolha qual deseja instalar: "
    read opcao
    echo_and_run $ANDROID_CMDL_TOOLS/sdkmanager --sdk_root=$ANDROID_SDK_ROOT --install "$opcao"
}

[[ -f $ANDROID_SDK_ROOT/emulator/emulator ]] || { return ; }


# Define path emulator
ANDROID_EMULATOR="$ANDROID_SDK_ROOT/emulator/emulator"

ct_androidRunEmulatorAVD() {
    echo "Escolha qual AVD?"
    echo 
    $ANDROID_EMULATOR -list-avds
    
    read AVD
    echo ""
    $ANDROID_EMULATOR -verbose -avd $AVD
}

export ANDROID_HOME=$ANDROID_SDK_ROOT
export ANDROID_AVD_HOME=/Android/AVD