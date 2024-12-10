pipeline {
    agent any

    tools {
        // Utilisez les noms configurés dans Jenkins
        maven 'Maven-3.8.7'   // Nom du Maven dans Jenkins
        jdk 'java-17-openjdk' // Nom du JDK dans Jenkins
        sonar 'SonarQubeScanner' // Nom correct du SonarQube Scanner dans Jenkins (ou 'SonarRunner' selon votre configuration)
    }

    environment {
        // Définir JAVA_HOME et M2_HOME en fonction des chemins exacts dans votre conteneur Jenkins
        JAVA_HOME = '/opt/java/openjdk'   // Le chemin vers Java dans votre conteneur Jenkins
        M2_HOME = '/usr/share/maven'      // Le chemin vers Maven dans votre conteneur Jenkins
        PATH = "${JAVA_HOME}/bin:${M2_HOME}/bin:${env.PATH}"
        
        // Définir le token d'authentification SonarQube dans l'environnement
        SONAR_TOKEN = credentials('sonartoken') // Récupérer le token SonarQube depuis Jenkins credentials
        SONARSERVER = 'sonarserver'  // Le nom du serveur SonarQube dans Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                // Récupérer le code source depuis GitHub
                checkout scm
            }
        }

        stage('Maven Clean') {
            steps {
                script {
                    echo "Running Maven clean..."
                    // Effectuer le nettoyage du projet Maven
                    sh 'mvn clean'
                }
            }
        }

        stage('Maven Build') {
            steps {
                script {
                    echo "Building with Maven..."
                    // Compiler le projet Maven
                    sh 'mvn install'
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    echo "Running Unit Tests..."
                    // Lancer les tests unitaires avec Maven (JUnit)
                    sh 'mvn test'
                }
            }
        }

        stage('Sonar Analysis') {
            environment {
                scannerHome = tool 'SonarQubeScanner' // Utiliser le SonarQube Scanner configuré dans Jenkins
            }
            steps {
                withSonarQubeEnv("${SONARSERVER}") {
                    sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                    -Dsonar.projectName=vprofile \
                    -Dsonar.projectVersion=1.0 \
                    -Dsonar.sources=src/ \
                    -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                    -Dsonar.junit.reportsPath=target/surefire-reports/ \
                    -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                    -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished!"
        }

        success {
            echo "Build and tests succeeded!"
        }

        failure {
            echo "Build or tests failed!"
        }
    }
}

