[[ -f /usr/bin/adb ]] || { return ; }

# https://www.automatetheplanet.com/adb-cheat-sheet/

# https://www.technipages.com/how-to-backup-your-entire-android-device
ct_adbBackupAll() {
    adb backup -all -f backup-android.ab
}

ct_adbListarTodosPacotesAPK() {
    adb shell pm list packages | awk -F':' '{print $2}'
}

ct_adbListaPathPacotesAPK() {
    for i in `ct_adbListarTodosPacotesAPK`
    do
        echo $i;
        echo "adb shell pm path "$i" | awk -F':' '{print $2}'"
    done    
}