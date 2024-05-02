# https://www.tecmint.com/mysql-mariadb-postgresql-database-backup-using-automysqlbackup-autopostgresqlbackup/

ct_pgadmin4_install() {
    #
    # Setup the repository
    #
    ubuntu_codename=jammy


    # Install the public key for the repository (if not done previously):
    curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg

    # Create the repository configuration file:
    sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$ubuntu_codename pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'
    
    sudo apt update;

    #
    # Install pgAdmin
    #

    # Install for both desktop and web modes:
    sudo apt install pgadmin4

    # Install for desktop mode only:
    sudo apt install pgadmin4-desktop

    # Install for web mode only: 
    sudo apt install pgadmin4-web 

    # Configure the webserver, if you installed pgadmin4-web:
    sudo /usr/pgadmin4/bin/setup-web.sh
}