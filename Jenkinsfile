pipeline {
    agent any

    stages {
        stage('liniting') {
            steps {
                echo 'Linting code...'
            }
        }
        stage('building-image') {
            steps {
                echo 'Building image...'
            }
        }
        stage('pushing-image-to-docker-hub') {
            steps {
                echo 'Pushing image...'
            }
        }
        stage('deploying-to-aws-eks') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}