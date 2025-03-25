#!/bin/bash
echo "🚀 Deploying to QA Environment..."

# Stop the running application (if applicable)
pm2 stop qa-app || true

# Move files to the QA environment directory
rsync -avz --exclude 'node_modules' . /var/www/qa-app/

# Change directory to the deployment folder
cd /var/www/qa-app/

# Install dependencies
npm install --production

# Restart the application
pm2 start server.js --name qa-app

echo "✅ Deployment to QA Completed!"
