

[[ -f /Android/Sdk/emulator/emulator ]] || { return ; }

# Define path emulator
ANDROID_EMULATOR="/Android/Sdk/emulator/emulator"

ct_androidRunEmulatorAVD() {
    echo "Escolha qual AVD?"
    echo 
    $ANDROID_EMULATOR -list-avds
    
    read AVD
    echo ""
    $ANDROID_EMULATOR -verbose -avd $AVD
}


export ANDROID_HOME=/Android/Sdk    
export ANDROID_SDK_ROOT=/Android/Sdk
export ANDROID_AVD_HOME=/Android/Sdk/emulator