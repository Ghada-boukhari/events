pipeline {
    agent any
    environment {
        GIT_CREDENTIALS = credentials('37c13848-cde5-4c4f-a61f-d5fc53c161b2') // ID exact des credentials SSH
    }
    stages {
        stage('Checkout') {
            steps {
                // Cloner le code depuis GitHub en utilisant l'URL SSH et les credentials configurés
                git url: 'git@github.com:Ghada-boukhari/events.git', branch: 'main', credentialsId: '37c13848-cde5-4c4f-a61f-d5fc53c161b2'
            }
        }
        stage('Build') {
            steps {
                // Construire le projet avec Maven
                sh 'mvn clean install'
            }
        }
        stage('Test') {
            steps {
                // Exécuter les tests Maven
                sh 'mvn test'
            }
        }
    }
}

