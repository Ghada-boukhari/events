pipeline {
    agent any

    tools {
        // Utilisation des outils configurés dans Jenkins
        maven 'Maven-3.8.7'  // Nom du Maven dans Jenkins
        jdk 'java-17-openjdk'  // Nom du JDK dans Jenkins
    }

    environment {
        // Définir le token SonarQube depuis les credentials Jenkins
        SONAR_TOKEN = credentials('sonartoken')  // Utilisation du token SonarQube depuis Jenkins credentials
        SONARSERVER = 'http://192.168.33.10:9000'  // Remplacer par l'URL de votre serveur SonarQube local
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
                    // Utilisation de SonarQube avec le plugin Maven au lieu de sonar-scanner
                    sh '''mvn sonar:sonar \
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

