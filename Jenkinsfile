pipeline {
  agent any
  stages {
    stage('initialize Consuela') {
      parallel {
        stage('initialize Consuela') {
          steps {
            sh '''sudo cp Consuela.sh /usr/bin
mkdir test'''
            sh '''cd test
sudo Consuela.sh --ayuda
sudo Consuela.sh --descanso 44M
cd ..
sudo Consuela.sh --limpiar test'''
          }
        }

        stage('Test Monica') {
          steps {
            sh 'sudo ./Monica.sh id'
          }
        }

      }
    }

  }
}