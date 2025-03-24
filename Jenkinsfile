pipeline {
    agent any

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Git branch to build')
    }

    environment {
        SLACK_CHANNEL = '#ci-cd-notifications'
        SLACK_CREDENTIALS_ID = 'slack-token'
        GIT_REPO = 'https://github.com/puneeth890/forte-free-lance.git'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: "${GIT_REPO}", branch: "${params.BRANCH_NAME}"
            }
        }

        stage('Build') {
            steps {
                echo "Running build for ${params.BRANCH_NAME} branch..."
                // Add actual build commands here
                sh 'mvn clean package'  // Example for Java
            }
        }

        stage('Deploy to Dev') {
            when {
                expression { params.BRANCH_NAME == 'develop' }
            }
            steps {
                echo "Deploying to DEV environment..."
                // Dev deployment steps
            }
        }

        stage('Deploy to QA') {
            when {
                expression { params.BRANCH_NAME == 'qa' }
            }
            steps {
                echo "Deploying to QA environment..."
                // QA deployment steps
            }
        }
    }

    post {
        success {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: 'good',
                message: "✅ SUCCESS: Job *${env.JOB_NAME}* #${env.BUILD_NUMBER} on branch *${params.BRANCH_NAME}*"
            )
        }
        failure {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: 'danger',
                message: "❌ FAILURE: Job *${env.JOB_NAME}* #${env.BUILD_NUMBER} on branch *${params.BRANCH_NAME}*"
            )
        }
    }
}
