pipeline {
    agent any

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
		    sh 'docker build -t blinkit-backend-app:latest .'
	        }
  	    }
	}
		
    }
}

