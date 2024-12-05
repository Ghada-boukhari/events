pipeline {
    agent any

    tools {
        // Utilisez le nom exact tel que défini dans la configuration des outils de Jenkins
        maven 'Maven-3.9.9'   // Le nom de Maven configuré dans Global Tool Configuration
        jdk 'java-17-openjdk' // Le nom du JDK configuré dans Global Tool Configuration
    }

    environment {
        // Assurez-vous de définir JAVA_HOME et M2_HOME avec les chemins corrects
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64/'  // Modifiez si nécessaire pour correspondre à votre installation
        M2_HOME = '/opt/apache-maven-3.9.9'                 // Modifiez si nécessaire pour correspondre à votre installation
        PATH = "${JAVA_HOME}/bin:${M2_HOME}/bin:${env.PATH}" // Ajoutez les répertoires bin au PATH
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
                    // Nettoyage du projet Maven
                    sh 'mvn clean'
                }
            }
        }

        stage('Maven Build') {
            steps {
                script {
                    echo "Building with Maven..."
                    // Compilation du projet Maven
                    sh 'mvn install'
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    echo "Running Unit Tests..."
                    // Exécution des tests unitaires avec Maven
                    sh 'mvn test'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "Deploying the application..."
                    // Ajoutez ici la commande pour déployer votre application si nécessaire
                    // Exemple : sh 'mvn deploy'
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

        unstable {
            echo "Build unstable!"
        }
    }
}
