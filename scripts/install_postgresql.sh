#!/bin/bash
DB_USER=$1
DB_PASS=$2

wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/postgresql.list'
sudo apt-get update
sudo apt-get install -y postgresql-12
sudo systemctl daemon-reload
sudo systemctl enable postgresql
sudo systemctl restart postgresql
cd /tmp
sudo -u postgres psql -c "CREATE DATABASE homer_config;"
sudo -u postgres psql -c "CREATE DATABASE homer_data;"
sudo -u postgres psql -c "CREATE ROLE ${DB_USER} WITH SUPERUSER LOGIN PASSWORD '$DB_PASS';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE homer_config to ${DB_USER};"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE homer_data to ${DB_USER};"

