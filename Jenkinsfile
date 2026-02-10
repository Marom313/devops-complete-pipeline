pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        ECR_REPO = "025707649967.dkr.ecr.us-east-1.amazonaws.com/devops-home-task-api"
        IMAGE_TAG = "${BUILD_NUMBER}"
        APP_SERVER = "3.89.84.205"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                docker build -t devops-home-task-api:${IMAGE_TAG} .
                """
            }
        }

        stage('Login to ECR') {
            steps {
                sh """
                aws ecr get-login-password --region ${AWS_REGION} | \
                docker login --username AWS --password-stdin ${ECR_REPO}
                """
            }
        }

        stage('Tag & Push to ECR') {
            steps {
                sh """
                docker tag devops-home-task-api:${IMAGE_TAG} ${ECR_REPO}:${IMAGE_TAG}
                docker push ${ECR_REPO}:${IMAGE_TAG}
                """
            }
        }

        stage('Deploy to APP EC2') {
            steps {
                withCredentials([sshUserPrivateKey(
                    credentialsId: 'app-ec2-key',
                    keyFileVariable: 'SSH_KEY',
                    usernameVariable: 'SSH_USER'
                )]) {

                    sh """
                    ssh -i ${SSH_KEY} -o StrictHostKeyChecking=no ${SSH_USER}@${APP_SERVER} '
                        aws ecr get-login-password --region ${AWS_REGION} | \
                        docker login --username AWS --password-stdin ${ECR_REPO} &&
                        docker pull ${ECR_REPO}:${IMAGE_TAG} &&
                        docker stop devops-container || true &&
                        docker rm devops-container || true &&
                        docker run -d -p 8000:5000 --name devops-container ${ECR_REPO}:${IMAGE_TAG}
                    '
                    """
                }
            }
        }
    }
}
