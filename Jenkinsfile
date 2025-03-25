pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/puneeth890/forte-free-lance.git'
        SLACK_WEBHOOK = 'YOUR_SLACK_WEBHOOK_URL' // Replace with your actual webhook URL
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: env.GIT_REPO
            }
        }

        stage('Build - Dev') {
            steps {
                script {
                    echo 'Building in Dev Environment...'
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }

        stage('Test - Dev') {
            steps {
                script {
                    echo 'Running tests in Dev...'
                    sh 'npm test'
                }
            }
        }

        stage('Deploy - Dev') {
            steps {
                script {
                    echo 'Deploying to Dev Environment...'
                    sh './deploy-dev.sh'
                }
            }
        }

        stage('Build - QA') {
            steps {
                script {
                    echo 'Building in QA Environment...'
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }

        stage('Test - QA') {
            steps {
                script {
                    echo 'Running tests in QA...'
                    sh 'npm test'
                }
            }
        }

        stage('Deploy - QA') {
            steps {
                script {
                    echo 'Deploying to QA Environment...'
                    sh './deploy-qa.sh'
                }
            }
        }
    }

    post {
        success {
            script {
                echo 'Build & Deployment Successful! Sending Slack notification...'
                sh '''
                    curl -X POST -H 'Content-type: application/json' \
                    --data '{"text":"✅ Jenkins Build & Deployment Successful!"}' ${SLACK_WEBHOOK}
                '''
            }
        }
        failure {
            script {
                echo 'Build Failed! Sending Slack notification...'
                sh '''
                    curl -X POST -H 'Content-type: application/json' \
                    --data '{"text":"❌ Jenkins Build Failed!"}' ${SLACK_WEBHOOK}
                '''
            }
        }
    }
}
