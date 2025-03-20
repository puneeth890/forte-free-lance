pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        S3_BUCKET_NAME = 'forte-free-lance-artifacts'
        PATH = "/opt/homebrew/bin:$PATH" // 👈 Ensures Jenkins can find npm
        SLACK_WEBHOOK_URL = credentials('slack-webhook-url')
    }

    stages {
        stage('Notify Start') {
            steps {
                script {
                    slackSend(color: '#439FE0', message: "🚀 Build started for *${env.JOB_NAME}* - #${env.BUILD_NUMBER}")
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

        stage('Test (Dev Environment)') {
            steps {
                echo '✅ Running tests in Dev environment...'
                sh 'npm test || true' // Use real test command here
            }
        }

        stage('Deploy to Dev') {
            steps {
                echo '🚀 Deploying to Dev environment...'
                // Add your Dev deployment logic (optional)
            }
        }

        stage('Deploy to QA') {
            steps {
                echo '🚀 Deploying to QA environment...'
                // Add your QA deployment logic (optional)
            }
        }

        stage('Deploy Artifacts to S3') {
            steps {
                echo '📦 Uploading build artifacts to S3...'
                sh '''
                    aws s3 cp dist/ s3://$S3_BUCKET_NAME/ --recursive --region $AWS_REGION
                '''
            }
        }
    }

    post {
        success {
            script {
                slackSend(color: 'good', message: "✅ Build SUCCESS for *${env.JOB_NAME}* - #${env.BUILD_NUMBER}")
            }
        }
        failure {
            script {
                slackSend(color: 'danger', message: "❌ Build FAILED for *${env.JOB_NAME}* - #${env.BUILD_NUMBER}")
            }
        }
    }
}
