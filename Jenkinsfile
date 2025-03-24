pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/puneeth890/forte-free-lance.git'
            }
        }

        stage('Validate JSON') {
            steps {
                echo 'Validating JSON files...'
                sh '''
                set -e
                echo "Checking JSON syntax in all .json files..."
                for file in $(find . -name "*.json"); do
                    echo "Validating $file"
                    python3 -m json.tool "$file" > /dev/null
                done
                '''
            }
        }

        stage('Deploy to Dev') {
            steps {
                echo 'Deploying to Dev (placeholder step)...'
                // Replace this with actual deployment logic if needed
            }
        }

        stage('Deploy to QA') {
            steps {
                echo 'Deploying to QA (placeholder step)...'
                // Replace this with actual deployment logic if needed
            }
        }
    }

    post {
        success {
            echo '✅ All JSON files are valid. Pipeline completed successfully.'
        }
        failure {
            echo '❌ Pipeline failed. Check the logs above for JSON issues.'
        }
    }
}
