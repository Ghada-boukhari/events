pipeline {
    agent any

    tools {
        // Utilisation de Maven et JDK configurés dans Jenkins
        maven 'M2_HOME'  // Nom que vous avez défini pour Maven
        jdk 'JAVA_HOME'  // Nom que vous avez défini pour Java
    }

    stages {
        stage('Checkout') {
            steps {
                // Cloner votre projet depuis GitHub
                git branch: 'main', url: 'https://github.com/Ghada-boukhari/events.git'
            }
        }

        stage('Maven Clean') {
            steps {
                // Exécution de la commande Maven Clean
                sh 'mvn clean'
            }
        }

        stage('Maven Build') {
            steps {
                // Exécution de la commande Maven Build
                sh 'mvn install -DskipTests'
            }
        }

        stage('Run Unit Tests') {
            steps {
                // Exécution des tests unitaires avec Maven
                sh 'mvn test'
            }
        }

        // Étape pour les actions post-pipeline (si nécessaire)
        stage('Post Actions') {
            steps {
                echo 'Pipeline terminé !'
            }
        }
    }
}

