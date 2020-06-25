#!/usr/bin/env bash
echo "waiting for database to start..."
/wait.sh
echo "setting up database..."
bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:create db:migrate
echo "starting application server..."
rm -f tmp/pids/server.pid
bin/rails server -b 0.0.0.0 -p "$APPLICATION_PORT"
