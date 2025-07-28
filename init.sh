#!/bin/bash

cat <<EOF > .env
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
EOF

cat .env
