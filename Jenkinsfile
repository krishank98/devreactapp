pipeline {
    agent any

    
    environment {
        DOCKERHUB_USERNAME = credentials('dockerhub-username')
        DOCKERHUB_PASSWORD = credentials('dockerhub-password')
        DOCKER_IMAGE_NAME = 'krish2356/devractapp'
        GIT_COMMIT = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
        DOCKER_IMAGE_TAG = "app-${env.BUILD_NUMBER}-${GIT_COMMIT}"
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
