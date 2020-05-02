ct_eclipseCleanProject() {
	find ./ -name .settings -exec rm -fr {} \;
	find ./ -name .tern-project -exec rm {} \;
	find ./ -name .project -exec rm {} \;
	find ./ -name target -exec rm -fr {} \;
	find ./ -name .classpath -exec rm {} \;
	find ./ -name bin -exec rm -fr {} \;
}