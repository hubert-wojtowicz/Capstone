pipeline {
    environment {
        APP_NAME = "jokes-app"
        IMAGE_VERSION = "${BUILD_NUMBER}"
    }
    agent any

    stages {
        stage('sys-info') {
            steps {
                echo 'Display basic information...'
                echo "This is buuld number ${BUILD_NUMBER}"
                sh """
                    pwd
                    which bash
                    ls -la    
                    git --version
                    
                    python3 --version
                    which python3
                    
                    pip3 --version
                    which pip3
                    
                    pylint --version
                    
                    docker --version
                    hadolint -v
                    
                    aws --version
                    #kubectl version
                """
            }
        }
        stage('lint') {
            steps {
                echo 'Linting code...'
                withPythonEnv('python3'){
                    sh """
                        which python3
                    	pip install --upgrade pip &&\
		                    pip install -r requirements.txt
                        hadolint Dockerfile
                        pylint --disable=R,C,W1203,RP0401 src/app.py
                    """
                }
            }
        }
        stage('contenerize') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    echo 'contenerizing application ...'
                    sh """
                        echo "application to be put into docker image is ${APP_NAME}"
                        ls -la
                        
                        echo "Building image..."
                        docker build --tag="${APP_NAME}" .
                        
                        echo "Signing in to DockerHub account"
                        docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}
                        
                        docker tag "${APP_NAME}" "${env.dockerHubUser}/${APP_NAME}:${IMAGE_VERSION}"
                        docker push "${env.dockerHubUser}/${APP_NAME}:${IMAGE_VERSION}"
                        docker images
                        docker logout
                    """
	     	    }
            }
        }
        stage('deploy') {
            steps {
                echo 'Deploying....'
                withAWS(region:'eu-west-2', credentials: 'aws-cli') {
                    sh """
                        aws eks --region eu-west-2 update-kubeconfig --name Capstone-Cluster
                        kubectl describe deployment/jokes-app-deploy
                        kubectl set image deployments/jokes-app-deploy jokes-app=hubertos/jokes-app:${IMAGE_VERSION}
                        kubectl describe deployment/jokes-app-deploy
                    """
                }
            }
        }
    }
    post {
        always {
            echo 'Cleaning workspace...'
            sh """
            docker images
            docker system prune -f
            docker images
            """
            deleteDir() /* clean up our workspace */
        }
    }
}