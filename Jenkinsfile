pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Récupérer le code source depuis Git
            }
        }

    post {
        always {
            echo "Pipeline finished!"
        }
    }
}
}

