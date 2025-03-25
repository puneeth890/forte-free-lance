#!/bin/bash
echo "🚀 Deploying to Dev Environment..."

# Stop the running application (if applicable)
pm2 stop dev-app || true

# Move files to the Dev environment directory
rsync -avz --exclude 'node_modules' . /var/www/dev-app/

# Change directory to the deployment folder
cd /var/www/dev-app/

# Install dependencies
npm install --production

# Restart the application
pm2 start server.js --name dev-app

echo "✅ Deployment to Dev Completed!"
