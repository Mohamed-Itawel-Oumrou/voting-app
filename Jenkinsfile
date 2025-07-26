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
    success {
      mail to: 'muhammad.elhacen@gmail.com',
          subject: "Pipeline SUCCÈS : ${env.JOB_NAME}",
          body: "Le pipeline ${env.JOB_NAME} a réussi à ${env.BUILD_URL}."
      mail to: 'fatimdp2002@gmail.com',
          subject: "Pipeline SUCCÈS : ${env.JOB_NAME}",
          body: "Le pipeline ${env.JOB_NAME} a réussi à ${env.BUILD_URL}."
    }
    failure {
      mail to: 'muhammad.elhacen@gmail.com',
          subject: "Pipeline ÉCHEC : ${env.JOB_NAME}",
          body: "Le pipeline ${env.JOB_NAME} a échoué à ${env.BUILD_URL}."
      mail to: 'fatimdp2002@gmail.com',
          subject: "Pipeline ÉCHEC : ${env.JOB_NAME}",
          body: "Le pipeline ${env.JOB_NAME} a échoué à ${env.BUILD_URL}."
    }
    always {
      sh 'docker compose ps'
    }
  }
}
