pipeline {
    agent any
    environment {
        DISABLE_AUTH = 'true'
        DB_ENGINE    = 'sqlite'
	AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
    }

    stages {
        stage('Build') {
            steps {
                echo "Database engine is ${DB_ENGINE}"
                echo "DISABLE_AUTH is ${DISABLE_AUTH}"
		echo "AWS_ACCESS_KEY_ID is ${AWS_ACCESS_KEY_ID}"
                sh 'printenv'
            }
        }
    }
}
