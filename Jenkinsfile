pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-home-task .'
            }
        }
		
		stage('Run Docker Container') {
			steps {
				sh '''
				docker stop devops-container || true
				docker rm devops-container || true
				docker run -d -p 5000:5000 --name devops-container devops-home-task
				'''
			}
		}

    }
}
