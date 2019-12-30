pipeline {
  agent any
  stages {
    stage('initialize Consuela') {
      steps {
        sh '''sudo cp Consuela.sh /usr/bin
mkdir test
cd test
sudo Consuela.sh --descanso 44M
cd ..'''
        sh '''sudo Consuela.sh --ayuda
sudo Consuela.sh --limpiar test'''
      }
    }

  }
}