
-Xms128m -Xmx1024m -Djboss.server.log.dir=/opt/logs/ -Djava.net.preferIPv4Stack=true -Djava.awt.headless=true -Djboss.modules.policy-permissions=true -Djboss.modules.system.pkgs=org.jboss.logmanager -Dfile.encoding=UTF-8 -Dfile.io.encoding=UTF-8 -DjavaEncoding=UTF-8 -Duser.region=BR -Dorg.apache.tomcat.util.http.Parameters.MAX_COUNT=5000 -Duser.language=pt


-server -Xms128m -Xmx1024m -Dorg.jboss.resolver.warning=true -Djava.net.preferIPv4Stack=true -Dsun.rmi.dgc.client.gcInterval=3600 -Dsun.rmi.dgc.server.gcInterval=3600 -Djboss.modules.system.pkgs=org.jboss.byteman -Djava.awt.headless=true "-Dorg.jboss.boot.log.file=/home/desenv/jboss-eap-6.4/standalone/log/boot.log" "-Dlogging.configuration=file:/home/desenv/jboss-eap-6.4/standalone/configuration/logging.properties" "-Djboss.home.dir=/home/desenv/jboss-eap-6.4" -Dorg.jboss.logmanager.nocolor=true -Djboss.bind.address.management=localhost -DAMBIENTE_SRV=LOCAL -DRESOURCES_DIR=/projetos/resources/ -Duser.timezone="GMT-3" -Duser.region="BR" -Duser.language="pt" -Dorg.apache.tomcat.util.http.Parameters.MAX_COUNT="5000" -Dfile.encoding=ISO-8859-1 -Dfile.io.encoding=ISO-8859-1 -DjavaEncoding=ISO-8859-1

-server -Xms128m -Xmx1024m -Dorg.jboss.resolver.warning=true -Djava.net.preferIPv4Stack=true -Dsun.rmi.dgc.client.gcInterval=3600 -Dsun.rmi.dgc.server.gcInterval=3600 -Djboss.modules.system.pkgs=org.jboss.byteman -Djava.awt.headless=true "-Dorg.jboss.boot.log.file=/home/desenv/jboss-eap-6.4/standalone/log/boot.log" "-Dlogging.configuration=file:/home/desenv/jboss-eap-6.4/standalone/configuration/logging.properties" "-Djboss.home.dir=/home/desenv/jboss-eap-6.4" -Dorg.jboss.logmanager.nocolor=true -Djboss.bind.address.management=localhost -DAMBIENTE_SRV=LOCAL -DRESOURCES_DIR=/projetos/resources/ -Duser.timezone="GMT-3" -Duser.region="BR" -Duser.language="pt" -Dorg.apache.tomcat.util.http.Parameters.MAX_COUNT="5000" -Dfile.encoding=UTF-8 -Dfile.io.encoding=UTF-8 -DjavaEncoding=UTF-8


## Access Log igual do apache

- https://access.redhat.com/solutions/16101#EAP6
- https://access.redhat.com/solutions/185383

Editar standalone.xml

```xml

        <subsystem xmlns="urn:jboss:domain:web:2.2" default-virtual-server="default-host" native="false">
            <connector name="http" protocol="HTTP/1.1" scheme="http" socket-binding="http"/>
            <virtual-server name="default-host" enable-welcome-root="true">
                <alias name="localhost"/>
                   <access-log pattern="%h %l %u %t %r %s %b %{Referer}i %{User-Agent}i %{JSESSIONID}c">
                        <directory relative-to="jboss.server.log.dir" />
                    </access-log>
            </virtual-server>
        </subsystem>
``` 