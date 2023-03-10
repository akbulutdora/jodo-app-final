#!/bin/sh

set -e

apt install -y build-essential
apt install -y make

# Install the app's depedencies
mix deps.get
# mix deps.compile --force bcrypt_elixir


# Wait for Postgres to become available.
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER 
do
  echo "Postgres is unavailable - sleeping"
  sleep 1
done
echo "\nPostgres is available: continuing with database setup..."

# Will create the database if not already created and then 
# perform migrations
mix ecto.setup

echo "\n Launching Phoenix web server..."
mix phx.server