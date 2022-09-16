[[ `isWin` != "1" ]] || { return ; }

ct_x_prepare_to_display() {
    xauth list $DISPLAY > /tmp/.x
}

ct_x_export_display_as_root() {
    isRoot

    if [[ -f /tmp/.x ]] 
    then
        xauth add $(cat /tmp/.x)
        export DISPLAY=localhost:10.0
    else
        echo "arquivo /tmp/.x not found. Please, run as user ct_x_prepare_to_display"
    fi
}