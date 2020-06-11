
# TODO

ct_wildfly_installMysqlModule() {
    local VERSION="5.1.47"
    local FILE="mysql-connector-java-$VERSION"
    local URL="https://dev.mysql.com/get/Downloads/Connector-J/$FILE.tar.gz"

    cd /tmp
    wget $URL
    tar xzvf $FILE

    echo "Leia http://www.mastertheboss.com/jboss-server/jboss-datasource/jboss-datasource-configuration?showall=1"
    openAnyFile "http://www.mastertheboss.com/jboss-server/jboss-datasource/jboss-datasource-configuration?showall=1"

    __qualquerTeclaContinuar

    echo "######### Edite/Crie no src/main/java/META-INF/persistence.xml"

    echo '<?xml version="1.0" encoding="UTF-8"?>
<persistence xmlns="http://java.sun.com/xml/ns/persistence"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://java.sun.com/xml/ns/persistence http://java.sun.com/xml/ns/persistence/persistence_2_0.xsd"
    version="2.0">
 
    <persistence-unit name="livraria" transaction-type="JTA">
        <provider>org.hibernate.jpa.HibernatePersistenceProvider</provider>
 
        <!-- Dont forget to inform to your persistence.xml the datasource name -->
        <jta-data-source>java:jboss/datasources/social_network-ds</jta-data-source>
        <!-- Note: If you need to run a main class to popolate your database, remove the tag above -->
 
        <class>com.lucas.social_network.model.User</class>
 
        <!-- Once your are using a datasource, is not required to configure properties below -->
        <properties>
            <property name="javax.persistence.jdbc.driver" value="com.mysql.jdbc.Driver" />
            <property name="javax.persistence.jdbc.url" value="jdbc:mysql://localhost/YOUR_DATABASE_NAME" />
            <property name="javax.persistence.validation.mode" value="none" />
 
            <property name="hibernate.hbm2ddl.auto" value="update" />
            <property name="hibernate.show_sql" value="true" />
            <property name="hibernate.dialect" value="org.hibernate.dialect.MySQL5InnoDBDialect" />
        </properties>
    </persistence-unit>
</persistence>'

    echo "************* Copie a pasta para \$WILDFLY_HOME/modules/system/layers/base/com"
}