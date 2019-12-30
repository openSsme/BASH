pipeline {
  agent any
  stages {
    stage('initialize Consuela') {
      steps {
        sh '''sudo cp Consuela.sh /usr/bin
mkdir test
cd test
sudo Consuela.sh --nuell 44M
cd ..'''
        sh '''cd ..
sudo Consuela.sh --limpiar test'''
      }
    }

  }
}