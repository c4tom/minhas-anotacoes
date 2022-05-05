[[ -f /usr/bin/adb ]] || { 
    [[ $HASAPT = false ]] && { return; }
    ct_adb_install() {
        sudo apt install adb
    }    
    return ; 
}

# https://www.automatetheplanet.com/adb-cheat-sheet/

# https://www.technipages.com/how-to-backup-your-entire-android-device
ct_adb_backupAll() {
    adb backup -all -f backup-android.ab
}

ct_adb_listarTodosPacotesAPK() {
    adb shell pm list packages | awk -F':' '{print $2}'
}

ct_adb_listaPathPacotesAPK() {
    for i in `ct_adbListarTodosPacotesAPK`
    do
        echo $i;
        echo "adb shell pm path "$i" | awk -F':' '{print $2}'"
    done    
}