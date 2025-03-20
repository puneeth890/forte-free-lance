pipeline {
    agent any

    environment {
        AWS_BUCKET = 'forte-free-lance-artifacts'
        SLACK_WEBHOOK_URL = credentials('slack-webhook-url')
    }

    stages {
        stage('Notify Start') {
            steps {
                script {
                    sh """
                    curl -X POST -H 'Content-type: application/json' --data '{"text":"🚀 Build Started: forte-free-lance-pipeline"}' $SLACK_WEBHOOK_URL
                    """
                }
            }
        }

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build App') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Deploy to AWS S3') {
            steps {
                sh """
                aws s3 cp ./dist/ s3://$AWS_BUCKET/ --recursive
                """
            }
        }
    }

    post {
        success {
            script {
                sh """
                curl -X POST -H 'Content-type: application/json' --data '{"text":"✅ Build Succeeded: forte-free-lance-pipeline"}' $SLACK_WEBHOOK_URL
                """
            }
        }
        failure {
            script {
                sh """
                curl -X POST -H 'Content-type: application/json' --data '{"text":"❌ Build Failed: forte-free-lance-pipeline"}' $SLACK_WEBHOOK_URL
                """
            }
        }
    }
}
