# https://hub.docker.com/r/library/sonarqube/

# Docker - instalação
# Senha: admin:admin na porta web 9000
# docker run -d --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube:alpine

# usando com maven
# https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner+for+Maven

# On Linux:
mvn_sonar() {
	MAVEN_OPTS="-Xmx512m"
	mvn clean verify sonar:sonar
}
