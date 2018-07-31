---
view: configuracoes-diversas
title: "Eclipse - Configurações"
description: "Conjunto de configurações para o Eclipse IDE"

---

# Workspaces
São salvos dentro de uma pasta workspace

## Projetos

Abrir a pasta: **.metadata/.plugins/org.eclipse.core.resources**
- histórico de modificações
- projetos


## Paramentros da linha de comandos
-vm \<path>		excute com outra versao instalado do java, caminho para o .../bin/java

-Xms\<size>		set initial Java heap size
-Xmx\<size>		set maximum Java heap size
-Xss\<size>		set java thread stack size
-d64 					flag is important as this tells the JVM to run in 64-bit mode.

Exemplos:
java -Xms16m -Xmx64m ClassName
In the above line we can set minimum heap to 16mb and maximum heap 64mb


java -Xmx6144M -d64


## Status Bar
Mostrar ou ocultar:
Quick Acess Field > digite: Toggle Visibility


## SpellChecking
Abrir Menu: Windows > Preferences > General > Editors > Text Editors > Spelling


## Charset Editor
Adicione nos argumentos para abrir o eclipse: -vmargs -Dfile.encoding=utf-8