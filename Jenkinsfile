pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/astrophagist/Terraform-Jenkins.git'
            }
	}
        stage('Plan') {
            steps {
                sh 'terraform init'
                sh "terraform plan -out tfplan"
                sh 'terraform show -no-color tfplan > tfplan.txt'
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
        stage('Apply') {
            steps {
                sh "terraform apply -input=false tfplan"
            }
        }
        stage('preview-destroy') {
            when {
                expression { params.action == 'preview-destroy' || params.action == 'destroy'}
            }
            steps {
                sh 'terraform plan -no-color -destroy -out=tfplan -var "aws_region=${AWS_REGION}" --var-file=environments/${ENVIRONMENT}.vars'
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }        
    }

}
