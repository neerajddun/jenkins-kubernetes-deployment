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
    stage('Deploying React.js container to Kubernetes') {
      steps {
        script {
          kubernetesDeploy(configs: ["deployment.yaml", "service.yaml"])
        }
      }
    }
  }
}
