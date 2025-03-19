pipeline {
    agent {
        docker {
            image 'node:16'  // Use a Node.js Docker image
            args '-v /tmp/.npm:/root/.npm'  // Persist npm cache
        }
    }

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['main', 'dev', 'qa'], description: 'Choose deployment environment')
    }

    stages {
        stage('Notify Start') {
            steps {
                script {
                    slackNotify("🚀 *Build Started* for `${params.ENVIRONMENT}` environment.")
                }
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: "${params.ENVIRONMENT}", url: 'https://github.com/puneeth890/forte-free-lance.git'
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
                sh '''
                    echo "Deploying to $ENVIRONMENT environment..."
                    aws s3 mb s3://forte-freelance-${params.ENVIRONMENT}-bucket || true
                    aws s3 sync ./dist s3://forte-freelance-${params.ENVIRONMENT}-bucket --delete
                '''
            }
        }
    }

    post {
        success {
            script {
                slackNotify("✅ *Build SUCCESSFUL* for `${params.ENVIRONMENT}` environment.")
            }
        }
        failure {
            script {
                slackNotify("❌ *Build FAILED* for `${params.ENVIRONMENT}` environment.")
            }
        }
    }
}
