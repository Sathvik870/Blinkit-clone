pipeline {
    agent any
    environment {
        IMAGE_NAME = "sathvikayyasamy/blinkit-backend-app"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    stages {

        stage('Checkout') {
            agent any
	    steps {
                echo 'Repository cloned successfully'
            }
        }

        stage('Install Dependencies') {
	    agent {
		docker {
		    image 'node:24-alpine'
                    reuseNode true
		}
            }

            steps {
                dir('backend') {
                    sh 'npm install'
                }
            }
        }
	
	stage('Run test') {
	    agent {
		docker {
		    image 'node:24-alpine'
                    reuseNode true
		}
	    }
	    steps {
		dir('backend'){
		    sh 'npm run test'
		}
	    }
	}
	
	stage('Build docker image'){
	    agent any
	    steps {
		dir('backend'){
		    sh '''
                       docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                       docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
                    '''
	        }
	    }
	}
	stage('Push Docker Image') {
             agent any

              steps {
                   withCredentials([usernamePassword(
                       credentialsId: 'dockerhub-creds',
                       usernameVariable: 'DOCKER_USERNAME',
                       passwordVariable: 'DOCKER_PASSWORD'
              )]) {
                sh '''
                   echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

                   docker push ${IMAGE_NAME}:${IMAGE_TAG}
                   docker push ${IMAGE_NAME}:latest
 
                   docker logout
                '''
               }
            }
        }
	stage('Deploy') {
              agent any
              steps {
                sh '''
                   docker pull ${IMAGE_NAME}:latest

                   docker stop blinkit-backend-app || true
                   docker rm blinkit-backend-app || true

                   docker run -d \
                     --name blinkit-backend-app \
                     --env-file ${WORKSPACE}/backend/.env \
                     -p 5000:5000 \
                     ${IMAGE_NAME}:latest
           
                   echo "Deployment Successful!"
		 '''
             }
        }
    }
}
