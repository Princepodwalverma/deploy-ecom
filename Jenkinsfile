pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
    ECR_REPO = '649966626274.dkr.ecr.us-east-1.amazonaws.com/ecom-app'
  }

  stages {

    stage('Build') {
      steps {
        sh 'docker build -t ecom-app .'
      }
    }

    stage('Login ECR') {
      steps {
        sh '''
        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin 649966626274.dkr.ecr.us-east-1.amazonaws.com
        '''
      }
    }

    stage('Push Image') {
      steps {
        sh '''
        docker tag ecom-app:latest $ECR_REPO:latest
        docker push $ECR_REPO:latest
        '''
      }
    }

    stage('Deploy') {
      steps {
        sh 'kubectl apply -f deployment.yaml'
        sh 'kubectl apply -f service.yaml'
      }
    }
  }
}