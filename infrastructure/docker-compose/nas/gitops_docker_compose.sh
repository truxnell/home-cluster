#!/bin/bash

# Set the repository URL and local directory to clone the repository
REPO_URL="https://github.com/your-username/your-repo.git"
LOCAL_DIR="/path/to/your/local/repo"

# Set the Docker Compose file path within the repository
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Function to initialize the local directory (clone the repository) if needed
function init_local_directory() {
    if [ ! -d "$LOCAL_DIR" ]; then
        echo "Initializing local directory..."
        git clone "$REPO_URL" "$LOCAL_DIR"
    fi
}

# Function to update the Docker Compose file and restart the stack
function update_and_restart() {
    cd "$LOCAL_DIR" || exit 1

    # Pull the latest changes from the remote repository
    git pull origin main

    # Restart the Docker Compose stack using the updated file
    docker-compose down
    docker-compose up -d

    echo "Docker Compose stack updated and restarted."
}

# Initialize the local directory (clone the repository) if needed
init_local_directory

# Update the Docker Compose file and restart the stack
update_and_restart
