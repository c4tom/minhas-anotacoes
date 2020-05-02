
# precisa instalar pigz

ct_backupMyHomeWithEncrypted() {

    tar -cv --use-compress-program=pigz -f backup-$USER.tar.gz \
    --exclude=backup-name.tar.gz\
    --exclude=.cache \
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
    --exclude=".local/share/NuGet/v3-cache" \
    --exclude=".wine/drive_c/users/can/Application Data/VOS" \
    --exclude=Templates /home/$USER
}