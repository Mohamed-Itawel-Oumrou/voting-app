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
        sh 'docker compose --env-file .env build --no-cache vote result worker nginx sonarqube'
      }
    }

    stage('Deploy') {
      steps {
        sh 'docker compose --env-file .env down -v vote result worker redis db nginx sonarqube'
        sh 'docker compose --env-file .env up -d vote result worker redis db nginx sonarqube'
      }
    }

    stage('Push') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
          sh '''
            echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USER" --password-stdin

            docker tag voting-app-pipeline-vote $DOCKERHUB_USER/voting-app:vote
            docker tag voting-app-pipeline-result $DOCKERHUB_USER/voting-app:result
            docker tag voting-app-pipeline-worker $DOCKERHUB_USER/voting-app:worker

            docker push $DOCKERHUB_USER/voting-app:vote
            docker push $DOCKERHUB_USER/voting-app:result
            docker push $DOCKERHUB_USER/voting-app:worker
          '''
        }
      }
    }

    stage('SonarQube Analysis') {
      steps {
        withSonarQubeEnv('SonarLocal') {
          script {
            def scannerHome = tool 'Default'
            sh "${scannerHome}/bin/sonar-scanner"
          }
        }
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
      mail to: 'oureye130203@gmail.com',
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
      mail to: 'oureye130203@gmail.com',
          subject: "Pipeline ÉCHEC : ${env.JOB_NAME}",
          body: "Le pipeline ${env.JOB_NAME} a échoué à ${env.BUILD_URL}."
    }
    always {
      sh 'docker compose ps'
    }
  }
}
