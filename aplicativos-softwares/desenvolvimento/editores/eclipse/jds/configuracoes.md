
/desenv/jbdevstudio10/studio/configuration/.settings/org.eclipse.ui.ide.prefs
```
MAX_RECENT_WORKSPACES=10
RECENT_WORKSPACES=/home/user/workspace_jds10
RECENT_WORKSPACES_PROTOCOL=3
SHOW_RECENT_WORKSPACES=false
SHOW_WORKSPACE_SELECTION_DIALOG=true
eclipse.preferences.version=1
```


Parametros de Inicialização do JBOSS EAP 6.x
```
"-Dprogram.name=JBossTools: EAP 6.4 JDK 8 ISO-8859-1" -server -Xms1024m -Xmx1024m -Dorg.jboss.resolver.warning=true -Djava.net.preferIPv4Stack=true -Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000 -Djboss.modules.system.pkgs=org.jboss.byteman -Djava.awt.headless=true "-Dorg.jboss.boot.log.file=/home/desenv/jboss-eap-6.4/standalone/log/boot.log" "-Dlogging.configuration=file:/home/desenv/jboss-eap-6.4/standalone/configuration/logging.properties" "-Djboss.home.dir=/home/desenv/jboss-eap-6.4" -Dorg.jboss.logmanager.nocolor=true -Djboss.bind.address.management=localhost -Duser.timezone="GMT-3" -Duser.region="BR" -Duser.language="pt" -Dorg.apache.tomcat.util.http.Parameters.MAX_COUNT="5000" -Dfile.encoding=ISO-8859-1 -Dfile.io.encoding=ISO-8859-1 -DjavaEncoding=ISO-8859-1 -Djava.io.tmpdir=/desenv/tmp/ -DAMBIENTE_SRV=HML -DRESOURCES_DIR=/projetos/resources/


-DAMBIENTE_SRV=HML -DRESOURCES_DIR=/projetos/resources/ -Duser.timezone="GMT-3" -Duser.region="BR" -Duser.language="pt" -DjavaEncoding=ISO-8859-1 


"-Dprogram.name=JBossTools: EAP 6.4 JDK 8 UTF-8" -server -Xms1024m -Xmx1024m -Dorg.jboss.resolver.warning=true -Djava.net.preferIPv4Stack=true -Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000 -Djboss.modules.system.pkgs=org.jboss.byteman -Djava.awt.headless=true "-Dorg.jboss.boot.log.file=/home/desenv/jboss-eap-6.4/standalone/log/boot.log" "-Dlogging.configuration=file:/home/desenv/jboss-eap-6.4/standalone/configuration/logging.properties" "-Djboss.home.dir=/home/desenv/jboss-eap-6.4" -Dorg.jboss.logmanager.nocolor=true -Djboss.bind.address.management=localhost -Duser.timezone="GMT-3" -Duser.region="BR" -Duser.language="pt" -Dorg.apache.tomcat.util.http.Parameters.MAX_COUNT="5000" -Dfile.encoding=UTF-8 -Dfile.io.encoding=UTF-8 -DjavaEncoding=UTF-8 -Djava.io.tmpdir=/desenv/tmp/ -DAMBIENTE_SRV=LOCAL -DRESOURCES_DIR=/projetos/resources/


```