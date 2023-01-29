ct_lvm_dashboard() {
    echo_and_run lvmdiskscan
    echo_and_run vgdisplay
    echo_and_run agpvdisplay
    echo_and_run vgdisplay
}

