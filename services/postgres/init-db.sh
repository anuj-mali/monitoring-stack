#!/bin/bash
set -e

create_db() {
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "postgres" \
        -tc "SELECT 1 FROM pg_database WHERE datname = '$1'" | grep -q 1 \
        || psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "postgres" \
           -c "CREATE DATABASE $1"
}

create_db mlflow
create_db litellm
create_db grafana
