pipeline {
    agent any

    tools {
        maven 'Maven-3.8.7'
        jdk 'java-17-openjdk'
    }

    environment {
        SONAR_TOKEN = credentials('sonartoken')
        SONARSERVER = 'http://192.168.33.10:9000'
        MAVEN_SETTINGS = '/home/vagrant/.m2/settings.xml'
        DOCKER_HOST = 'tcp://172.17.0.5:2375'
    }

    stages {
        stage('Checkout') {
            steps {
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
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                        sh "docker build -t ghadaboukhari/eventsproject:latest ."
                        sh "docker push ghadaboukhari/eventsproject:latest"
                    }
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                script {
                    echo "Deploying with Docker Compose..."
                    sh 'docker-compose up -d'
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
