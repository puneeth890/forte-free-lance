pipeline {
    agent any

    environment {
        SLACK_CHANNEL = '#ci-cd-notifications'  // Your Slack channel
        SLACK_CREDENTIALS_ID = 'slack-token'    // Set this in Jenkins credentials
        GIT_REPO = 'https://github.com/puneeth890/forte-free-lance.git'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: "${GIT_REPO}", branch: "${env.BRANCH_NAME}"
            }
        }

        stage('Build') {
            steps {
                echo "Running build for ${env.BRANCH_NAME} branch..."
                // Add actual build commands here
            }
        }

        stage('Deploy to Dev') {
            when {
                branch 'develop'
            }
            steps {
                echo "Deploying to DEV environment..."
                // Add Dev deployment commands here
            }
        }

        stage('Deploy to QA') {
            when {
                branch 'qa'
            }
            steps {
                echo "Deploying to QA environment..."
                // Add QA deployment commands here
            }
        }
    }

    post {
        success {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: 'good',
                message: "✅ SUCCESS: Job *${env.JOB_NAME}* #${env.BUILD_NUMBER} on branch *${env.BRANCH_NAME}*"
            )
        }
        failure {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: 'danger',
                message: "❌ FAILURE: Job *${env.JOB_NAME}* #${env.BUILD_NUMBER} on branch *${env.BRANCH_NAME}*"
            )
        }
    }
}
