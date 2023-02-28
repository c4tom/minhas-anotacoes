
# precisa instalar pigz

ct_backupMyHomeWithEncrypted() {
    local DATE=$(date '+%Y%m%d%H%M%S')

    echo_and_run tar -cv --use-compress-program=pigz -f backup-$USER-$DATE.tar.gz \
    --exclude=backup-name.tar.gz\
    --exclude=.cache \
    --exclude=.config/Code/Cache* \
    --exclude=.config/Code/logs \
    --exclude=.config/Code/Crashpad \
    --exclude=".config/Code/Service Worker/CacheStorage" \
    --exclude=".config/google-chrome/Crash Reports" \
    --exclude="*/CacheStorage/*" \
    --exclude="*/Cache/*" \
    --exclude="*/cache/*" \
    --exclude="*/Code Cache/*" \
    --exclude=.debug \
    --exclude=.dbus \
    --exclude=.gvfs \
    --exclude=.local/share/gvfs-metadata \
    --exclude=.local/share/Trash \
    --exclude=.recently-used \
    --exclude=.thumbnails \
    --exclude=.xsession-errors \
    --exclude=.Trash \
    --exclude=.m2 \
    --exclude=Public \
    --exclude=.Private \
    --exclude=.zohoworkdrive \
    --exclude=.npm \
    --exclude=".local/share/NuGet/v3-cache" \
    --exclude=".wine/drive_c/users/can/Application Data/VOS" \
    --exclude="VirtualBox VMs" \
    --exclude=Templates /home/$USER
}