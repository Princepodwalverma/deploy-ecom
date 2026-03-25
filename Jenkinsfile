pipeline {
agent any

```
environment {
    AWS_REGION = 'us-east-1'
    ECR_REPO = '649966626274.dkr.ecr.us-east-1.amazonaws.com/ecom-app'
    IMAGE_TAG = 'latest'
}

stages {

    stage('Checkout') {
        steps {
            git 'https://github.com/Princepodwalverma/deploy-ecom.git'
        }
    }

    stage('Build Docker Image') {
        steps {
            sh 'docker build -t ecom-app .'
        }
    }

    stage('Login to ECR') {
        steps {
            withCredentials([[
                $class: 'AmazonWebServicesCredentialsBinding',
                credentialsId: 'aws-creds'
            ]]) {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin 649966626274.dkr.ecr.us-east-1.amazonaws.com
                '''
            }
        }
    }

    stage('Tag Image') {
        steps {
            sh 'docker tag ecom-app:latest $ECR_REPO:$IMAGE_TAG'
        }
    }

    stage('Push to ECR') {
        steps {
            sh 'docker push $ECR_REPO:$IMAGE_TAG'
        }
    }

    stage('Deploy to EKS') {
        steps {
            sh 'kubectl apply -f deployment.yaml'
            sh 'kubectl apply -f service.yaml'
        }
    }
}
```

}
