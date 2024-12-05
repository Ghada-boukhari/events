pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Clone le projet depuis GitHub
                git branch: 'main', url: 'https://github.com/Ghada-boukhari/events.git'
            }
        }

        stage('Maven Clean') {
            steps {
                // Nettoyer le projet
                sh 'mvn clean'
            }
        }

        stage('Maven Build') {
            steps {
                // Construire le projet
                sh 'mvn compile'
            }
        }

        stage('Run Unit Tests') {
            steps {
                // Exécuter les tests unitaires
                sh 'mvn test'
            }
        }
    }

    post {
        success {
            echo 'Pipeline terminé avec succès.'
        }
        failure {
            echo 'Le pipeline a échoué.'
        }
    }
}

