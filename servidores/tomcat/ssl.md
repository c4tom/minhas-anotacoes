

## Gerando Propria Chave

To create a new JKS keystore from scratch, containing a single self-signed Certificate, execute the following from a terminal command line:

`type -p keytool`  -genkey -alias tomcat -keyalg RSA -keystore tomcat.key

obs: tomcat.key nesta configuração foi colocado na pasta conf do apache-tomcat

**editar arquivo conf/server.xml**

Descomente e adicione certificateKeystorePassword
```
    <Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
               maxThreads="150" SSLEnabled="true">
        <SSLHostConfig>
            <Certificate certificateKeystoreFile="conf/tomcat.key" certificateKeystorePassword="password" type="RSA" />
        </SSLHostConfig>
    </Connector>
```

reiniciar

## Usando CRT Fornecido
keytool -import -trustcacerts -alias server -file seu_dominio_com_br.crt -keystore minha_keystore.jks



## Referencia
- https://tomcat.apache.org/tomcat-9.0-doc/ssl-howto.html#Configuration
- https://clientes.globessl.com.br/knowledgebase.php?action=displayarticle&id=5
- https://o7planning.org/en/12243/install-a-free-ssl-certificate-lets-encrypt-for-tomcat-server-on-ubuntu#a36099252