pipeline {
  agent any
  stages {
    stage('initialize Consuela') {
      steps {
        sh 'sudo cp Consuela.sh /usr/bin'
        sh 'mkdir test'
        sh 'cd test'
        sh 'sudo Consuela.sh --nuell 44M'
      }
    }

    stage('test Consuela') {
      steps {
        sh 'sudo Consuela.sh --limpiar test'
      }
    }

  }
}