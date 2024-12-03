pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }
    
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    
    stages{
        stage ('git checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/rakeshbijigi/jenkins-terraform-docker.git'
            }
        }
        
        stage ('terraform init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        
        stage ('terraform plan') {
            steps {
                script {
                    sh 'terraform plan -out tfplan'
                    sh 'terraform show -no-color tfplan > tfplan.txt'
                }
            }
        }
        
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }
        
        
        
        stage ('terraform apply') {
            steps {
                script {
                    sh 'terraform apply -input=false tfplan'
                }
            }
            
        }
    }
}
