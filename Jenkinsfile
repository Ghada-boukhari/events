pipeline {
    agent any
    environment {
        GIT_CREDENTIALS = credentials('github-credentials') // Utilise les credentials SSH pour GitHub
    }
    stages {
        stage('Checkout') {
            steps {
                // Récupérer le code depuis GitHub en utilisant l'URL SSH et la clé privée dans Jenkins
                git url: 'git@github.com:Ghada-boukhari/events.git', branch: 'main', credentialsId: 'github-credentials'
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

