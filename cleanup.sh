#!/usr/bin/env bash
set -e

echo ">>> Stopping and removing containers, networks, volumes..."
docker compose --profile connect down -v --remove-orphans

echo ">>> Removing dangling volumes (if any)..."
docker volume prune -f

echo ">>> Removing dangling networks (if any)..."
docker network prune -f

echo ">>> Cleanup complete."

