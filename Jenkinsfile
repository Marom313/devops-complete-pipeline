pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        ECR_REPO = "025707649967.dkr.ecr.us-east-1.amazonaws.com/devops-home-task-api"
        IMAGE_TAG = "latest"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t devops-home-task-api:${IMAGE_TAG} .
                '''
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region ${AWS_REGION} | \
                docker login --username AWS --password-stdin ${ECR_REPO}
                '''
            }
        }

        stage('Tag & Push to ECR') {
            steps {
                sh '''
                docker tag devops-home-task-api:${IMAGE_TAG} ${ECR_REPO}:${IMAGE_TAG}
                docker push ${ECR_REPO}:${IMAGE_TAG}
                '''
            }
        }
    }
}
