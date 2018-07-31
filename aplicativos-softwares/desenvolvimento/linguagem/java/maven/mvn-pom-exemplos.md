


## Plugins

https://maven.apache.org/plugins/
https://maven.apache.org/plugin-tools/index.html

![img](https://maven.apache.org/plugin-tools/images/plugin-tools-deps.png)


### Eclipse (depreciado)
- [WTP Version](http://maven.apache.org/plugins/maven-eclipse-plugin/wtp.html)
  - use: -Dwtpversion=2.0

- [Adicionando Facets](http://maven.apache.org/plugins/maven-eclipse-plugin/examples/additional-facets.html)


- UTF-8
```xml

<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-eclipse-plugin</artifactId>
	<version>2.10</version>
	<configuration>
		<additionalProjectFacets>
			<jst.jsf>2.0</jst.jsf>
		</additionalProjectFacets>
		<additionalConfig>
			<file>
				<name>.settings/org.eclipse.core.resources.prefs</name>
				<content>
					<![CDATA[eclipse.preferences.version=1${line.separator}encoding/<project>=${project.build.sourceEncoding}${line.separator}]]>
				</content>
			</file>
		</additionalConfig>					
	</configuration>
</plugin>

<properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>
```


Exemplo Projeto WEB (pom.xml)
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>com.cht</groupId>
	<artifactId>cht</artifactId>
	<version>1.0.0</version>
	<packaging>war</packaging>
	<name>Site CHT</name>
	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<jdk.version>1.8</jdk.version>
	</properties>
	<build>
		<finalName>${project.artifactId}</finalName>
		<resources>
			<resource>
				<directory>src/main/java</directory>
				<excludes>
					<exclude>**/*.java</exclude>
				</excludes>
			</resource>
			<resource>
				<directory>src/main/resources</directory>
				<excludes>
					<exclude>**/*.java</exclude>
				</excludes>
			</resource>
		</resources>
		<plugins>
			<plugin>
				<artifactId>maven-compiler-plugin</artifactId>
				<version>3.5.1</version>
				<configuration>
					<source>${jdk.version}</source>
					<target>${jdk.version}</target>
					<encoding>${project.build.sourceEncoding}</encoding>
				</configuration>
			</plugin>
			<plugin>
				<artifactId>maven-war-plugin</artifactId>
				<version>3.0.0</version>
			</plugin>
		</plugins>
	</build>
	<dependencies>

	</dependecies>
</project>
```


Example para JBOSS

```xml
        <!-- First declare the APIs we depend on and need for compilation.
            All of them are provided by JBoss EAP -->

        <!-- Import the CDI API, we use provided scope as the API is included in JBoss EAP -->
        <dependency>
            <groupId>javax.enterprise</groupId>
            <artifactId>cdi-api</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- Import the Common Annotations API (JSR-250), we use provided
            scope as the API is included in JBoss EAP -->
        <dependency>
            <groupId>org.jboss.spec.javax.annotation</groupId>
            <artifactId>jboss-annotations-api_1.1_spec</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- Import the JAX-RS API, we use provided scope as the API is included in JBoss EAP -->
        <dependency>
            <groupId>org.jboss.spec.javax.ws.rs</groupId>
            <artifactId>jboss-jaxrs-api_1.1_spec</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- Import the JPA API, we use provided scope as the API is included in JBoss EAP -->
        <dependency>
            <groupId>org.hibernate.javax.persistence</groupId>
            <artifactId>hibernate-jpa-2.0-api</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- Import the EJB API, we use provided scope as the API is included in JBoss EAP -->
        <dependency>
            <groupId>org.jboss.spec.javax.ejb</groupId>
            <artifactId>jboss-ejb-api_3.1_spec</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- JSR-303 (Bean Validation) Implementation -->
        <!-- Provides portable constraints such as @Email -->
        <!-- Hibernate Validator is shipped in JBoss EAP -->
        <dependency>
            <groupId>org.hibernate</groupId>
            <artifactId>hibernate-validator</artifactId>
            <scope>provided</scope>
            <exclusions>
                <exclusion>
                    <groupId>org.slf4j</groupId>
                    <artifactId>slf4j-api</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <!-- Import the JSF API, we use provided scope as the API is included in JBoss EAP -->
        <dependency>
            <groupId>org.jboss.spec.javax.faces</groupId>
            <artifactId>jboss-jsf-api_2.1_spec</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- Import the Servlet API, we use provided scope as the API is included in JBoss EAP -->
        <dependency>
            <groupId>org.jboss.spec.javax.servlet</groupId>
            <artifactId>jboss-servlet-api_3.0_spec</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- Import the RichFaces library -->
        <dependency>
            <groupId>org.richfaces</groupId>
            <artifactId>richfaces</artifactId>
        </dependency>

        <!-- Import the Atmosphere framework for a4j:push -->
        <dependency>
            <groupId>org.atmosphere</groupId>
            <artifactId>atmosphere-runtime</artifactId>
            <exclusions>
                <exclusion>
                    <groupId>org.slf4j</groupId>
                    <artifactId>slf4j-api</artifactId>
                </exclusion>
            </exclusions>
        </dependency>

        <!-- Now we declare any tools needed -->

        <!-- Annotation processor to generate the JPA 2.0 metamodel classes
            for typesafe criteria queries -->
        <dependency>
            <groupId>org.hibernate</groupId>
            <artifactId>hibernate-jpamodelgen</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- The rewrite library allows us to do url rewriting - used here for rewriting mobile devices to mobile specific views -->
        <dependency>
            <groupId>org.ocpsoft.rewrite</groupId>
            <artifactId>rewrite-servlet</artifactId>
            <version>${version.org.ocpsoft.rewrite}</version>
        </dependency>

        <!-- The cdi integration allows for CDI injection into the rewrite configuration class -->
        <dependency>
            <groupId>org.ocpsoft.rewrite</groupId>
            <artifactId>rewrite-integration-cdi</artifactId>
            <version>${version.org.ocpsoft.rewrite}</version>
        </dependency>

        <!-- Annotation processor that raising compilation errors whenever
            constraint annotations are incorrectly used. -->
        <dependency>
            <groupId>org.hibernate</groupId>
            <artifactId>hibernate-validator-annotation-processor</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- Needed for running tests (you may also use TestNG) -->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- Optional, but highly recommended -->
        <!-- Arquillian allows you to test enterprise code such as EJBs and
            Transactional(JTA) JPA from JUnit/TestNG -->
        <dependency>
            <groupId>org.jboss.arquillian.junit</groupId>
            <artifactId>arquillian-junit-container</artifactId>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.jboss.arquillian.protocol</groupId>
            <artifactId>arquillian-protocol-servlet</artifactId>
            <scope>test</scope>
        </dependency>
```


Web Project TomCat

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.cht</groupId>
    <artifactId>chtweb</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>war</packaging>
    <name>CHT WEB</name>
    <description>CHT com RichFaces</description>

    <properties>
        <!-- Explicitly declaring the source encoding eliminates the following message: -->
        <!-- [WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent! -->
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>

        <!-- Define the version of the JBoss BOMs we want to import to specify tested stacks. -->
        <version.richfaces>4.5.1.Final</version.richfaces>

        <!-- other plugin versions -->
        <version.war.plugin>2.1.1</version.war.plugin>
        <org.ocpsoft.rewrite.version>2.0.12.Final</org.ocpsoft.rewrite.version>

        <!-- maven-compiler-plugin -->
        <maven.compiler.target>1.8</maven.compiler.target>
        <maven.compiler.source>1.8</maven.compiler.source>
    </properties>


    <dependencies>

        <!-- Import the RichFaces library -->
        <dependency>
            <groupId>org.richfaces</groupId>
            <artifactId>richfaces</artifactId>
            <version>${version.richfaces}</version>
        </dependency>

        <!-- Import the RichFaces push dependencies -->
        <dependency>
            <groupId>org.richfaces</groupId>
            <artifactId>richfaces-push-depchain</artifactId>
            <version>${version.richfaces}</version>
            <type>pom</type>
        </dependency>

        <!-- Now we declare any tools needed -->

        <!-- Annotation processor to generate the JPA 2.0 metamodel classes for typesafe criteria queries -->
        <dependency>
            <groupId>org.hibernate</groupId>
            <artifactId>hibernate-jpamodelgen</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- The rewrite library allows us to do url rewriting - used here for rewriting mobile devices to mobile specific views -->
        <dependency>
            <groupId>org.ocpsoft.rewrite</groupId>
            <artifactId>rewrite-servlet</artifactId>
            <version>${org.ocpsoft.rewrite.version}</version>
        </dependency>

        <!-- The cdi integration allows for CDI injection into the rewrite configuration class -->
        <dependency>
            <groupId>org.ocpsoft.rewrite</groupId>
            <artifactId>rewrite-integration-cdi</artifactId>
            <version>${org.ocpsoft.rewrite.version}</version>
        </dependency>

        <!-- Annotation processor that raising compilation errors whenever
            constraint annotations are incorrectly used. -->
        <dependency>
            <groupId>org.hibernate</groupId>
            <artifactId>hibernate-validator-annotation-processor</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- Needed for running tests (you may also use TestNG) -->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <scope>test</scope>
        </dependency>

        <!-- Optional, but highly recommended -->
        <!-- Arquillian allows you to test enterprise code such as EJBs and
            Transactional(JTA) JPA from JUnit/TestNG -->
        <dependency>
            <groupId>org.jboss.arquillian.junit</groupId>
            <artifactId>arquillian-junit-container</artifactId>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.jboss.arquillian.protocol</groupId>
            <artifactId>arquillian-protocol-servlet</artifactId>
            <scope>test</scope>
        </dependency>

    </dependencies>

    <build>
        <!-- Maven will append the version to the finalName (which is the
            name given to the generated war, and hence the context root) -->
        <finalName>${project.artifactId}</finalName>
        <plugins>
            <plugin>
                <artifactId>maven-war-plugin</artifactId>
                <version>${version.war.plugin}</version>
                <configuration>
                    <!-- Java EE 6 doesn't require web.xml, Maven needs to catch up! -->
                    <failOnMissingWebXml>false</failOnMissingWebXml>
                </configuration>
            </plugin>
        </plugins>
    </build>

    <profiles>
        <profile>
            <!-- When built in OpenShift the 'openshift' profile will be used when invoking mvn. -->
            <!-- Use this profile for any OpenShift specific customization your app will need. -->
            <!-- By default that is to put the resulting archive into the 'deployments' folder. -->
            <!-- http://maven.apache.org/guides/mini/guide-building-for-different-environments.html -->
            <id>openshift</id>
            <build>
                <plugins>
                    <plugin>
                        <artifactId>maven-war-plugin</artifactId>
                        <version>${version.war.plugin}</version>
                        <configuration>
                            <outputDirectory>deployments</outputDirectory>
                            <warName>ROOT</warName>
                        </configuration>
                    </plugin>
                </plugins>
            </build>
        </profile>

        <profile>
            <!-- Activate this profile to identify to the IDE which version of the JSF impl is being used by the
                application server.-->
            <!-- Be sure to include the JBoss maven repository, as the JBoss jsf-impl artifacts are not in maven
                central. -->
            <!-- See: https://community.jboss.org/wiki/MavenGettingStarted-Developers -->
            <id>debug</id>
            <dependencies>
                <!-- Import the JSF impl, to allow for application debugging -->
                <dependency>
                    <groupId>com.sun.faces</groupId>
                    <artifactId>jsf-impl</artifactId>
                    <scope>provided</scope>
                </dependency>
            </dependencies>
        </profile>

    </profiles>
</project>

```