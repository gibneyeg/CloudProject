#!/bin/bash

echo "Starting deployment..."

# Pull latest changes
git pull origin main


bundle install

RAILS_ENV=production rails db:migrate

RAILS_ENV=production rails assets:precompile

# Restart the server
kill -9 $(cat tmp/pids/server.pid) 2>/dev/null || true
RAILS_ENV=production rails server -d -b 0.0.0.0 -p 3000

echo "Deployment completed!"
