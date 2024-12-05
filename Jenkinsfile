pipeline {
    agent any

    tools {
        // Utilisez le nom exact tel que défini dans la configuration des outils de Jenkins
        maven 'Maven-3.9.9'    // Le nom de Maven configuré dans Global Tool Configuration
        jdk 'java-17-openjdk'  // Le nom du JDK configuré dans Global Tool Configuration
    }

    environment {
        // Assurez-vous de définir JAVA_HOME et M2_HOME avec les chemins corrects
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64/'  // Modifiez si nécessaire pour correspondre à votre installation
        M2_HOME = '/opt/apache-maven-3.9.9' // Modifiez si nécessaire pour correspondre à votre installation
        PATH = "${JAVA_HOME}/bin:${M2_HOME}/bin:${env.PATH}"  // Ajoutez les répertoires bin au PATH
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Récupérer le code source depuis Git
            }
        }

        stage('Maven Clean') {
            steps {
                script {
                    echo "Running Maven clean..."
                    sh 'mvn clean'  // Nettoyage avec Maven
                }
            }
        }

        stage('Maven Build') {
            steps {
                script {
                    echo "Building with Maven..."
                    sh 'mvn install'  // Compiler avec Maven
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    echo "Running Unit Tests..."
                    sh 'mvn test'  // Exécuter les tests unitaires avec Maven
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished!"
        }
    }
}
