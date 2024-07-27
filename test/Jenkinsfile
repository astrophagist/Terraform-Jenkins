pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        STACK_NAME = 'test-terraform-state-infrastructure'
        TEMPLATE_FILE = 's3_backend.yaml'
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the version control system
                git 'https://github.com/astrophagist/Terraform-Jenkins.git'
            }
        }
        stage('Deploy CloudFormation Stack') {
            steps {
                withEnv(["AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID}", "AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY}"]) {
                    sh """
                    aws cloudformation deploy \
                        --region ${env.AWS_REGION} \
                        --stack-name ${env.STACK_NAME} \
                        --template-file ${env.TEMPLATE_FILE} \
                        --capabilities CAPABILITY_NAMED_IAM
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'CloudFormation stack deployed successfully.'
        }
        failure {
            echo 'Failed to deploy CloudFormation stack.'
        }
    }
}
