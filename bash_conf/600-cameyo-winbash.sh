[[ `isWin` == "1" ]] || { return ; }

CAMEYO_EXE=/d/Downloads/Cameyo/Cameyo.exe


CameyoCapture() {
    $CAMEYO_EXE -StartCapture
}

CameyoCaptureInstall ()
{
    local EXEFILE="$1"
    local OUTPUTEXE="$2"
    $CAMEYO_EXE -GhostCapture $EXEFILE -OutputExe:$OUTPUTEXE
}

CameyoAppInfo() {
    local CAMEYO_APP_FILE="$1"

    $CAMEYO_APP_FILE -info

}

CameyoAppUpdate() {
    echo
}