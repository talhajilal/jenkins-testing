pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'sudo sh $PWD/hello.sh'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing 123..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
