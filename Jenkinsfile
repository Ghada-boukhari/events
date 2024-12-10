pipeline {
    agent any

    tools {
        // Utilisez les noms configurés dans Jenkins (ou dans le conteneur si vous les avez installés manuellement)
        maven 'Maven-3.8.7'   // Nom du Maven dans Jenkins
        jdk 'java-17-openjdk' // Nom du JDK dans Jenkins
    }

    environment {
        // Définir JAVA_HOME et M2_HOME en fonction des chemins exacts dans votre conteneur Jenkins
        JAVA_HOME = '/opt/java/openjdk'   // Le chemin vers Java dans votre conteneur Jenkins
        M2_HOME = '/usr/share/maven'      // Le chemin vers Maven dans votre conteneur Jenkins
        PATH = "${JAVA_HOME}/bin:${M2_HOME}/bin:${env.PATH}"
        SONAR_TOKEN = credentials('events-token') // Récupérer le token SonarQube depuis Jenkins credentials
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

        stage('SonarQube Analysis') {
            steps {
                script {
                    echo "Running SonarQube analysis..."
                    // Effectuer l'analyse de qualité du code avec SonarQube
                    withSonarQubeEnv('sonar') { // Utiliser les credentials SonarQube configurés dans Jenkins
                        sh 'mvn sonar:sonar -Dsonar.login=${SONAR_TOKEN}'
                    }
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

