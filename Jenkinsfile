pipeline {
  agent any
  stages {
    stage('pull') {
      steps {
        sh '''sudo cp Consuela.sh /usr/bin
sudo Consuela.sh --nuell 10M'''
      }
    }

  }
}