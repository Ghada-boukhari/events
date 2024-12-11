pipeline {
    agent any

    tools {
        // Utilisation des outils configurés dans Jenkins
        maven 'Maven-3.8.7'  // Nom du Maven configuré dans Jenkins
        jdk 'java-17-openjdk'  // Nom du JDK configuré dans Jenkins
    }

    environment {
        // Variables d'environnement
        DOCKER_CREDENTIALS_ID = 'dockerhub_credentials' // ID des credentials Docker Hub dans Jenkins
        DOCKER_IMAGE_NAME = 'ghadaboukhari/events:latest' // Nom de l'image Docker
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
                    sh 'mvn clean'
                }
            }
        }

        stage('Maven Build') {
            steps {
                script {
                    echo "Building with Maven..."
                    sh 'mvn install'
                }
            }
        }

        stage('Run Unit Tests') {
            steps {
                script {
                    echo "Running Unit Tests..."
                    sh 'mvn test'
                }
            }
        }

        stage('Generate JaCoCo Report') {
            steps {
                script {
                    echo "Generating JaCoCo coverage report..."
                    sh 'mvn jacoco:report'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    echo "Running SonarQube analysis..."
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
                        -Dsonar.login=${SONAR_TOKEN} \
                        -Dsonar.host.url=${SONARSERVER}
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh """
                    docker build -t ${DOCKER_IMAGE_NAME} .
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo "Pushing Docker image to Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push ${DOCKER_IMAGE_NAME}
                        docker logout
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed."
        }
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed. Please check the logs."
        }
    }
}

