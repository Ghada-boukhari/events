pipeline {
    agent any

    tools {
        maven 'Maven-3.8.7'  // Nom du Maven dans Jenkins
        jdk 'java-17-openjdk'  // Nom du JDK dans Jenkins
    }

    environment {
        // Variables d'environnement
        SONAR_TOKEN = credentials('sonartoken')  // Token SonarQube depuis Jenkins credentials
        SONARSERVER = 'http://192.168.33.10:9000'  // URL du serveur SonarQube
        MAVEN_SETTINGS = '/home/vagrant/.m2/settings.xml'  // Chemin vers le fichier settings.xml pour Nexus
        DOCKER_USERNAME = credentials('dockerhub_credentials')  // ID des credentials Docker Hub
        DOCKER_PASSWORD = credentials('dockerhub_credentials')  // ID des credentials Docker Hub
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

        stage('Docker Build and Push') {
            steps {
                script {
                    echo "Building Docker image..."
                    // Connexion à Docker Hub
                    sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                    // Construction de l'image Docker
                    sh "docker build -t ghadaboukhari/eventsproject:latest ."
                    // Push de l'image vers Docker Hub
                    sh "docker push ghadaboukhari/eventsproject:latest"
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

