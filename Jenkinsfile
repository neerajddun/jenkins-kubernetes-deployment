pipeline {
  environment {
    dockerimagename = "neeraj91/react-app"
    registryCredential = 'dockerhub-credentials'
  }
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        git 'https://github.com/neerajddun/jenkins-kubernetes-deployment.git'
      }
    }
    
    stage('Build image') {
      steps {
        script {
          dockerImage = docker.build("${dockerimagename}:latest")
        }
      }
    }
    
    stage('Pushing Image') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
            dockerImage.push("latest")
          }
        }
      }
    }
    
    stage('Deploying to Kubernetes') {
      steps {
        script {
          // Option 1: Using kubectl directly (requires kubectl configured on Jenkins)
          sh 'kubectl apply -f deployment.yaml'
          sh 'kubectl apply -f service.yaml'
          
          // Option 2: Using Kubernetes plugin if installed
          // kubernetesApply(configs: ['deployment.yaml', 'service.yaml'], kubeconfigId: 'k8s-credentials')
        }
      }
    }
  }
}