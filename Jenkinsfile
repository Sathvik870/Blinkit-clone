pipeline {
    agent {
	docker {
	    image 'node:24-alpine'
	}
    } 

    stages {

        stage('Checkout') {
            steps {
                echo 'Repository cloned successfully'
            }
        }

        stage('Backend Files') {
            steps {
                dir('backend') {
                    sh 'pwd'
                    sh 'ls -la'
                }
            }
        }

        stage('Node Version') {
            steps {
                dir('backend') {
                    sh 'node -v'
                    sh 'npm -v'
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                dir('backend') {
                    sh 'npm install'
                }
            }
        }
    }
}
