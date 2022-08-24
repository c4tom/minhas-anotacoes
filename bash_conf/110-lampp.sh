[[ `isWin` == "1" ]] || { return ; }

[[ -f /desenv/lampp-php5/bin/php ]] || { return ; }
[[ -f /desenv/lampp-php7/bin/php ]] || { return ; }

# PATH_ORIGINAL defined 000-bash

lampp_set_php5() {
    export LAMPP=/desenv/lampp-php5
    export LD_LIBRARY_PATH=$LAMPP/lib
    export PATH=$PATH_ORIGINAL:$LAMPP/bin:$LAMPP/sbin
    lampp_manager
}

lampp_set_php7() {
    export LAMPP=/desenv/lampp-php7
    export LD_LIBRARY_PATH=$LAMPP/lib
    export PATH=$PATH_ORIGINAL:$LAMPP/bin:$LAMPP/sbin
    lampp_manager
}

lampp_manager()
{
    echo $LAMPP
    
    sudo ln -sf $LAMPP/lampp /usr/bin/lampp

    sudo ldconfig
    sudo rm -f /opt/lampp
    sudo ln -sf $LAMPP /opt/lampp
    cd $LAMPP
    sudo $LAMPP/manager-linux-x64.run
}

lampp_reset_config() {
    export PATH=$PATH_ORIGINAL
    export LD_LIBRARY_PATH=
}

# PHP 5 como padrao
#lampp_set_php5
