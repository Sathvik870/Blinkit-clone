pipeline {
    agent any

    stages {

        stage('Clone Successful') {
            steps {
                echo 'Repository cloned successfully!'
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
    }
}
