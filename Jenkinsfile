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

        stage('Install Dependencies') {
            steps {
                dir('backend') {
                    sh 'npm install'
                }
            }
        }
	
	stage('Run test') {
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
