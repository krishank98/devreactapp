pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = credentials('dockerhub-username')
        DOCKERHUB_PASSWORD = credentials('dockerhub-password')
        DOCKER_IMAGE_NAME = 'krish2356/devractapp'
        DOCKER_IMAGE_TAG = "app-${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/krishank98/devreactapp.git'
            }
        }

        stage('Build') {
            steps {
                sh 'export NODE_OPTIONS=--openssl-legacy-provider'
                sh 'npm install'
                sh 'npm run build'
                sh 'npm prune --production'
                sh 'cp Dockerfile dist/' // Assuming your Dockerfile is in the root directory
            }
        }

        stage('Docker Build and Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        def dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
