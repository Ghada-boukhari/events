pipeline {
    agent any

    tools {
        maven 'M2_HOME' // Utilisez le nom défini dans Jenkins pour Maven
        jdk 'JAVA_HOME'  // Utilisez le nom défini dans Jenkins pour Java
    }

    stages {
        stage('Checkout') {
            steps {
                // Cloner le dépôt depuis GitHub
                git branch: 'main', url: 'https://github.com/Ghada-boukhari/events.git'
            }
        }

        stage('Maven Clean') {
            steps {
                // Exécuter la commande Maven clean
                sh 'mvn clean'
            }
        }

        stage('Maven Build') {
            steps {
                // Exécuter la commande Maven pour construire le projet
                sh 'mvn package'
            }
        }

        stage('Run Unit Tests') {
            steps {
                // Exécuter les tests unitaires avec Maven
                sh 'mvn test'
            }
        }
    }

    post {
        always {
            // Action après le pipeline
            echo 'Pipeline terminé.'
        }
    }
}


