pipeline {
    agent any

    tools {
        // Configure Maven et Java
        maven 'Maven-3.9.9'  // Assurez-vous que "Maven-3.9.9" est correctement configuré dans Jenkins
        jdk 'java-17-openjdk'  // Assurez-vous que "java-17-openjdk" est correctement configuré dans Jenkins
    }

    environment {
        // Définir JAVA_HOME et MAVEN_HOME explicitement si nécessaire
        JAVA_HOME = tool name: 'java-17-openjdk', type: 'JDK'
        MAVEN_HOME = tool name: 'Maven-3.9.9', type: 'Maven'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone du projet depuis GitHub
                git branch: 'main', url: 'https://github.com/Ghada-boukhari/events.git'
            }
        }

        stage('Maven Clean') {
            steps {
                // Nettoyer le projet Maven avant de le reconstruire
                sh 'mvn clean'
            }
        }

        stage('Maven Build') {
            steps {
                // Compiler et construire le projet Maven
                sh 'mvn install -DskipTests'
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
        always {
            // Actions après le pipeline (si nécessaire, par exemple pour les notifications)
            echo 'Pipeline terminé'
        }
        success {
            // Actions si le pipeline réussit (par exemple, pour notifier ou archiver les artefacts)
            echo 'Le pipeline a réussi avec succès !'
        }
        failure {
            // Actions en cas d'échec du pipeline
            echo 'Le pipeline a échoué.'
        }
    }
}

