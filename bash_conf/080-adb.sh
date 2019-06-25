[[ -f /usr/bin/adb ]] || { return ; }

# https://www.technipages.com/how-to-backup-your-entire-android-device
ct_adbBackupAll() {
    adb backup -all -f backup-android.ab
}
