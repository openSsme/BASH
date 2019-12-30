pipeline {
  agent any
  stages {
    stage('initialize Consuela') {
      parallel {
        stage('initialize Consuela') {
          steps {
            sh 'sudo cp Consuela.sh /usr/bin'
          }
        }

        stage('create test directory') {
          steps {
            sh 'mkdir test'
          }
        }

        stage('cd test directory') {
          steps {
            sh 'cd test/'
          }
        }

        stage('prepare test files') {
          steps {
            sh 'sudo Consuela.sh --nuel 44M'
          }
        }

      }
    }

    stage('test Consuela') {
      steps {
        sh 'sudo Consuela.sh --limpiar test'
      }
    }

  }
}