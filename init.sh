#!/bin/bash

cat <<EOF > .env
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
EOF

cat .env
