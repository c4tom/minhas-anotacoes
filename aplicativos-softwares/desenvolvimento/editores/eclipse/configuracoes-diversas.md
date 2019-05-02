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



c:\Users\can\workspace_jds\.metadata\.plugins\org.eclipse.core.runtime\.settings\org.eclipse.ui.workbench.prefs
```
ENABLED_DECORATORS=org.eclipse.m2e.core.mavenVersionDecorator\:false,org.eclipse.wst.server.ui.decorator\:false,org.eclipse.wst.jsdt.chromium.debug.ui.decorators.ChromiumJavaScript\:true,org.eclipse.jst.ws.jaxws.dom.integration.navigator.WebServiceDecorator\:true,org.eclipse.ui.LinkedResourceDecorator\:true,org.eclipse.ui.SymlinkDecorator\:true,org.eclipse.ui.VirtualResourceDecorator\:true,org.eclipse.ui.ContentTypeDecorator\:true,org.eclipse.ui.ResourceFilterDecorator\:false,org.eclipse.datatools.connectivity.sqm.core.internal.ui.explorer.DependencyDecoration\:true,org.eclipse.datatools.connectivity.sqm.core.internal.ui.explorer.ColumnDecoration\:true,org.eclipse.datatools.connectivity.sqm.core.internal.ui.explorer.ForeignKeyDecoration\:true,org.eclipse.datatools.connectivity.sqm.core.internal.ui.explorer.IndexTriggerDecoration\:true,org.eclipse.datatools.connectivity.internal.core.ui.bookmarkDecoration\:true,org.eclipse.datatools.connectivity.internal.core.ui.FilterNodeDecoration\:true,org.eclipse.wst.json.bower.ui.bower\:true,org.eclipse.wst.json.bower.ui.bowerrc\:true,org.eclipse.wst.json.eslint.ui.ESLint\:true,org.eclipse.wst.json.jshint.ui.jshint\:true,org.eclipse.wst.json.npm.ui.NPM\:true,org.eclipse.mylyn.context.ui.decorator.interest\:true,org.eclipse.debug.ui.prototype.decorator\:true,org.eclipse.datatools.enablement.sybase.systemtabledecorator\:true,org.eclipse.rse.subsystems.error.decorator\:true,org.eclipse.datatools.connectivity.ui.decorator.contentextension\:false,org.eclipse.m2e.core.maven2decorator\:true,org.eclipse.datatools.enablement.ingres.ui.providers.decorators.SynonymDecorationService\:true,org.eclipse.datatools.enablement.ingres.internal.ui.providers.decorators.ParameterDecorationService\:true,org.eclipse.mylyn.tasks.ui.decorators.task\:true,org.eclipse.team.cvs.ui.decorator\:false,org.sonarlint.eclipse.ui.navigatorDecorator\:true,org.sonarlint.eclipse.ui.sonarlintDecorator\:true,org.fusesource.ide.project.decorator.problem.route\:true,org.eclipse.jdt.ui.override.decorator\:true,org.eclipse.jdt.ui.interface.decorator\:true,org.eclipse.jdt.ui.buildpath.decorator\:true,org.eclipse.jdt.internal.ui.without.test.code.decorator\:true,org.eclipse.wst.server.ui.navigatorDecorator\:true,org.eclipse.jst.j2ee.navigator.internal.J2EEProjectDecorator\:true,org.eclipse.datatools.enablement.sybase.asa.proxytabledecorator\:true,org.eclipse.datatools.enablement.sybase.ase.webservicetabledecorator\:true,org.eclipse.rse.core.virtualobject.decorator\:true,org.eclipse.rse.core.binary.executable.decorator\:true,org.eclipse.rse.core.script.executable.decorator\:true,org.eclipse.rse.core.java.executable.decorator\:true,org.eclipse.rse.core.library.decorator\:true,org.eclipse.rse.core.link.decorator\:true,org.hibernate.eclipse.decorators.HibernateDecorator\:true,org.jboss.tools.jmx.ui.internal.views.navigator.JMXConnectionDecorator\:true,org.eclipse.wst.jsdt.ui.override.decorator\:true,org.eclipse.pde.ui.binaryProjectDecorator\:false,org.eclipse.egit.ui.internal.decorators.GitLightweightDecorator\:true,org.eclipse.egit.ui.internal.repository.RepositoryTreeNodeDecorator\:true,org.eclipse.buildship.ui.gradledecorator\:true,org.eclipse.jst.jee.ui.internal.navigator.ejb.BeanDecorator\:true,org.eclipse.jst.jee.navigator.internal.JEEProjectDecorator\:true,org.jboss.ide.eclipse.as.ui.extensions.xml.decorator\:true,org.jboss.ide.eclipse.as.ui.module.publish.decorator\:true,org.eclipse.jst.j2ee.internal.ui.util.AnnotationIconDecorator_servlet\:true,org.eclipse.jst.j2ee.internal.ui.util.AnnotationIconDecorator_ejb\:true,
PLUGINS_NOT_ACTIVATED_ON_STARTUP=;org.eclipse.m2e.discovery;
eclipse.preferences.version=1
```

c:\Users\can\workspace_jds\.metadata\.plugins\org.eclipse.core.runtime\.settings