[[ -f /desenv/lampp-php5/bin/php ]] || { return ; }
[[ -f /desenv/lampp-php7/bin/php ]] || { return ; }

export PATH_ORIGINAL=$PATH

lampp_set_php5() {
    export LAMPP=/desenv/lampp-php5
    export LD_LIBRARY_PATH=$LAMPP/lib
    export PATH=$PATH_ORIGINAL:$LAMPP/bin:$LAMPP/sbin
}

lampp_set_php7() {
    export LAMPP=/desenv/lampp-php7
    export LD_LIBRARY_PATH=$LAMPP/lib
    export PATH=$PATH_ORIGINAL:$LAMPP/bin:$LAMPP/sbin
}

lampp_manager()
{
    sudo ldconfig
    rm -f /opt/lampp
    sudo ln -sf $LAMPP /opt/lampp
    cd $LAMPP
    sudo $LAMPP/manager-linux-x64.run
}

lampp_set_php5
