pipeline {
  agent any
  stages {
    stage('pull') {
      steps {
        git(poll: true, url: 'git remote add origin https://github.com/openSsme/BASH', branch: 'master', credentialsId: 'github')
      }
    }

  }
}