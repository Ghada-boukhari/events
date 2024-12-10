pipeline {
    agent any

    tools {
        // Utilisation des outils configurés dans Jenkins
        maven 'Maven-3.8.7'  // Nom du Maven dans Jenkins
        jdk 'java-17-openjdk'  // Nom du JDK dans Jenkins
    }

    environment {
        // Définir le token SonarQube depuis les credentials Jenkins
        SONAR_TOKEN = credentials('sonartoken')  // Utilisation du token SonarQube depuis Jenkins credentials
        SONARSERVER = 'http://192.168.33.10:9000'  // URL du serveur SonarQube local
    }

    stages {
        stage('Checkout') {
            steps {
                // Récupérer le code source depuis le repository Git
                checkout scm
            }
        }

        stage('Maven Clean') {
            steps {
                script {
                    echo "Running Maven clean..."
                    // Exécuter la commande Maven clean
                    sh 'mvn clean'
                }
            }
        }

        stage('Maven Build') {
            steps {
                script {
                    echo "Building with Maven..."
                    // Compiler le projet avec Maven
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

        stage('Generate JaCoCo Report') {
            steps {
                script {
                    echo "Generating JaCoCo coverage report..."
                    // Générer le rapport JaCoCo avec Maven
                    sh 'mvn jacoco:report'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    echo "Running SonarQube analysis..."
                    // Lancer l'analyse SonarQube avec les paramètres configurés
                    sh """
                    mvn sonar:sonar \
                        -Dsonar.projectKey=backend \
                        -Dsonar.projectName=backend \
                        -Dsonar.projectVersion=1.0 \
                        -Dsonar.sources=src/main/java \
                        -Dsonar.tests=src/test/java \
                        -Dsonar.java.binaries=target/classes \
                        -Dsonar.junit.reportsPath=target/surefire-reports/ \
                        -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                        -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml \
                        -Dsonar.login=${SONAR_TOKEN} \
                        -Dsonar.host.url=${SONARSERVER}
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished!"
        }

        success {
            echo "Build and analysis succeeded!"
        }

        failure {
            echo "Build or analysis failed!"
        }
    }
}

