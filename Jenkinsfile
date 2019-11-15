pipeline {
    agent any

    stages {

        stage('Prepare') {
            steps {
                dir('build') {
                     sh 'git reset --hard HEAD'
                     sh 'git clean -d -f -x'
                     sh 'mkdir build'
                     sh 'cd build'
                     sh 'cmake ..'
                     sh 'make update -j8'
                }
            }
        }

        stage('Build') {
            steps {
                dir('build') {
                    sh 'make'
                }
            }
        }

        stage('Test') {
            steps {
                dir('build') {
                    sh 'make check'
                }
            }
        }

        stage('Package') {
            steps {
                dir('build') {
                    sh 'make package'
                }
            }
        }
    }

    post {
        always {

        }

        success {

        }
    }

}
