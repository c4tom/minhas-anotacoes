---
view: dicas
title: "Dicas para uso do Maven"
description: "Várias dicas para uso do maven"

---

# Dicas para Maven

## Geral
 - Para mostrar a lista de opções de um plugin
`mvn <nome-do-plugin>:<tab><tab>`
   - Veja também: 
     - [Lista de Plugins](https://maven.apache.org/plugins/)
     - Descrição das opções do plugin: 
       - ` mvn help:describe -Dplugin=eclipse`
 - Mostrar "Effective POM"
`mvn help:effective-pom`
`mvn help:effective-pom -Doutput=effective-pom.xml ` gera arquivo: **effective-pom.xml**
 - Adicionar ao POM principal (Charset)
```xml
...
<build>
  <plugins>
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-resources-plugin</artifactId>
      <version>2.4.3</version>
      <configuration>
        <encoding>ISO-8859-1</encoding>
      </configuration>
    </plugin>
  </plugins>
</build>
<properties>
  <project.build.sourceEncoding>ISO-8859-1</project.build.sourceEncoding>
  <project.reporting.outputEncoding>${project.build.sourceEncoding}</project.reporting.outputEncoding>

  <!-- compiler plugin configuation -->
  <maven.compiler.source>1.7</maven.compiler.source>
  <maven.compiler.target>1.7</maven.compiler.target>
  <maven.compiler.testSource>1.7</maven.compiler.testSource>
  <maven.compiler.testTarget>1.7</maven.compiler.testTarget>
  <maven.compiler.debug>true</maven.compiler.debug>
  <maven.compiler.debuglevel>lines,vars,source</maven.compiler.debuglevel>

  <!-- enable / disable Unit Tests -->
  <ut.maven.test.skip>true</ut.maven.test.skip>

  <!-- enable / disable Integration Tests -->
  <it.maven.test.skip>true</it.maven.test.skip>
</properties>

```


## Verificando Dependências do Projeto
`mvn dependency:tree`