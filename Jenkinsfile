pipeline {
  agent any

  stages {
    stage('Clone') {
      steps {
        git url: 'https://github.com/Mohamed-Itawel-Oumrou/voting-app', branch: 'master'
      }
    }

    stage('Init') {
      steps {
        sh 'chmod +x ./init.sh'
        sh './init.sh'
      }
    }

    stage('Build') {
      steps {
        sh 'docker compose --env-file .env build --no-cache vote result worker'
      }
    }

    stage('Deploy') {
      steps {
        sh 'docker compose --env-file .env down -v vote result worker redis db'
        sh 'docker compose --env-file .env up -d vote result worker redis db'
      }
    }
  }

  post {
    always {
      sh 'docker compose ps'
    }
  }
}
