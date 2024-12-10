# Utiliser une image de base OpenJDK
FROM openjdk:17-jdk-slim

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier JAR généré dans le conteneur
COPY target/eventsProject-1.0.0-SNAPSHOT.jar /app/eventsProject.jar

# Exposer le port sur lequel l'application va s'exécuter
EXPOSE 8089

# Commande pour exécuter l'application
ENTRYPOINT ["java", "-jar", "/app/eventsProject.jar"]

