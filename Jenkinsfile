pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1' // Update if your region is different
        S3_BUCKET_NAME = 'forte-free-lance-artifacts'
        SLACK_WEBHOOK_URL = credentials('slack-webhook-url') // Set this in Jenkins credentials
    }

    stages {
        stage('Notify Start') {
            steps {
                script {
                    slackSend(color: '#FFFF00', message: "🚀 Build started for *Forte Free Lance Project*")
                }
            }
        }

        stage('Checkout Code') {
            steps {
                git 'https://github.com/puneeth890/forte-free-lance.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    if [ -f package.json ]; then
                        npm install
                    fi
                '''
            }
        }

        stage('Build App') {
            steps {
                sh '''
                    echo "Building app..."
                    # Add your build commands here (e.g., npm run build)
                '''
            }
        }

        stage('Deploy to AWS S3') {
            steps {
                sh '''
                    echo "Deploying to S3..."
                    aws s3 cp ./dist s3://$S3_BUCKET_NAME/ --recursive
                '''
            }
        }
    }

    post {
        success {
            script {
                slackSend(color: '#36a64f', message: "✅ Build and deployment successful for *Forte Free Lance Project*")
            }
        }
        failure {
            script {
                slackSend(color: '#FF0000', message: "❌ Build failed for *Forte Free Lance Project*")
            }
        }
    }
}
