pipeline {
    agent any

    tools {
        // Utilisation des outils configurés dans Jenkins
        maven 'Maven-3.8.7'  // Nom du Maven dans Jenkins
        jdk 'java-17-openjdk'  // Nom du JDK dans Jenkins
       
    }

    environment {
        // Définir les chemins d'accès aux outils Java et Maven
        JAVA_HOME = '/opt/java/openjdk'  // Le chemin vers Java dans votre conteneur Jenkins
        M2_HOME = '/usr/share/maven'     // Le chemin vers Maven dans votre conteneur Jenkins
        PATH = "${JAVA_HOME}/bin:${M2_HOME}/bin:${env.PATH}"
        
        // Définir le token SonarQube depuis les credentials Jenkins
        SONAR_TOKEN = credentials('sonartoken')  // Utilisation du token SonarQube depuis Jenkins credentials
        SONARSERVER = 'http://192.168.33.10:9000'  // Remplacer par l'URL de votre serveur SonarQube local
        SONARSCANNER = 'SonarQubeScanner'
    }

    stages {
        stage('Checkout') {
            steps {
                // Récupérer le code source depuis le repository Git
                checkout scm
            }
        }

        stage('Maven Clean') {
            steps {
                script {
                    echo "Running Maven clean..."
                    // Exécuter la commande Maven clean
                    sh 'mvn clean'
                }
            }
        }

        stage('Maven Build') {
            steps {
                script {
                    echo "Building with Maven..."
                    // Compiler le projet avec Maven
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

        stage('SonarQube Analysis') {
            steps {
                script {
                    echo "Running SonarQube analysis..."
                    // Lancer l'analyse SonarQube avec les paramètres configurés
                    sh '''${SONARSCANNER}/bin/sonar-scanner \
                        -Dsonar.projectKey=backend \
                        -Dsonar.projectName=backend \
                        -Dsonar.projectVersion=1.0 \
                        -Dsonar.sources=src/ \
                        -Dsonar.java.binaries=target/classes \
                        -Dsonar.junit.reportsPath=target/surefire-reports/ \
                        -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                        -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml \
                        -Dsonar.login=${SONAR_TOKEN} \
                        -Dsonar.host.url=${SONARSERVER}'''
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

