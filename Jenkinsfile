pipeline {
    agent any

    tools {
        // Nom exact tel que défini dans Jenkins Tool Configuration
        maven 'Maven-3.9.9'    // Maven 3.9.9
        jdk 'java-17-openjdk'  // Java 17
    }

    environment {
        // Définition explicite des variables d'environnement
        JAVA_HOME = tool name: 'java-17-openjdk', type: 'JDK'
        M2_HOME = tool name: 'Maven-3.9.9', type: 'Maven'
        PATH = "${JAVA_HOME}/bin:${M2_HOME}/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Maven Clean') {
            steps {
                script {
                    echo "Running Maven clean..."
                    sh 'mvn clean'
                }
            }
        }

        stage('Maven Build') {
            steps {
                script {
                    echo "Running Maven build..."
                    sh 'mvn install'
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    echo "Running unit tests..."
                    sh 'mvn test'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
    }
}

